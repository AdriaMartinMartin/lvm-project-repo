#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Pretty-print Toy*Node{...} trees found anywhere in the input.
Accepts piped stdin, a single-arg string, or -f FILE.
"""

from collections import OrderedDict
import re
import sys

# ─────────────────────────── Lexer ───────────────────────────

class Tok:
    def __init__(self, kind, val=None, pos=0):
        self.kind, self.val, self.pos = kind, val, pos

class Lexer:
    def __init__(self, s):
        self.s, self.i, self.n = s, 0, len(s)
    def _peek(self): return self.s[self.i] if self.i < self.n else ''
    def _adv(self):  ch = self._peek(); self.i += 1; return ch
    def _ws(self):
        while self._peek() and self._peek().isspace(): self.i += 1

    def string(self):
        # single-quoted with simple escapes: \', \\
        assert self._adv() == "'"
        out = []
        while True:
            if self.i >= self.n: raise ValueError("Unterminated string")
            ch = self._adv()
            if ch == "\\":
                if self.i >= self.n: raise ValueError("Bad escape at end")
                nxt = self._adv()
                out.append("'" if nxt == "'" else ("\\" if nxt == "\\" else nxt))
            elif ch == "'":
                return ''.join(out)
            else:
                out.append(ch)

    def ident_or_bool(self):
        start = self.i
        ch = self._peek()
        if not (ch.isalpha() or ch == '_'):
            raise ValueError(f"Bad identifier at {self.i}")
        self.i += 1
        while self._peek() and (self._peek().isalnum() or self._peek() in '._'):
            self.i += 1
        word = self.s[start:self.i]
        if word == 'true':  return Tok('BOOL', True, start)
        if word == 'false': return Tok('BOOL', False, start)
        return Tok('IDENT', word, start)

    def number(self):
        start = self.i
        while self._peek() and self._peek().isdigit():
            self.i += 1
        return Tok('NUM', int(self.s[start:self.i]), start)

    def tokens(self):
        out = []
        while True:
            self._ws()
            if self.i >= self.n: break
            ch = self._peek()
            if ch == "'":
                out.append(Tok('STR', self.string(), self.i))
            elif ch.isdigit():
                out.append(self.number())
            elif ch.isalpha() or ch == '_':
                out.append(self.ident_or_bool())
            else:
                sym = self._adv()
                kind = {'{':'LBRACE','}':'RBRACE','[':'LBRACK',']':'RBRACK',',':'COMMA','=':'EQUAL'}.get(sym)
                if not kind:
                    raise ValueError(f"Unexpected char {sym!r} at {self.i-1}")
                out.append(Tok(kind, sym, self.i-1))
        out.append(Tok('EOF', None, self.i))
        return out

# ─────────────────────────── Parser ───────────────────────────

class Node:
    def __init__(self, name, fields):
        self.name = name
        self.fields = fields  # OrderedDict

class Parser:
    def __init__(self, toks):
        self.toks, self.i = toks, 0
    def peek(self): return self.toks[self.i]
    def eat(self, kind):
        t = self.peek()
        if t.kind != kind:
            raise ValueError(f"Expected {kind}, got {t.kind} at {t.pos}")
        self.i += 1
        return t

    def parse(self):
        val = self.value()
        self.eat('EOF')
        return val

    def value(self):
        t = self.peek()
        if t.kind == 'IDENT':
            name = t.val; self.i += 1
            if self.peek().kind == 'LBRACE':
                self.eat('LBRACE')
                fields = self.fields()
                self.eat('RBRACE')
                return Node(name, fields)
            else:
                return name
        elif t.kind == 'STR':
            return self.eat('STR').val
        elif t.kind == 'NUM':
            return self.eat('NUM').val
        elif t.kind == 'BOOL':
            return self.eat('BOOL').val
        elif t.kind == 'LBRACK':
            return self.list_()
        else:
            raise ValueError(f"Unexpected token {t.kind} at {t.pos}")

    def list_(self):
        self.eat('LBRACK')
        items = []
        if self.peek().kind != 'RBRACK':
            while True:
                items.append(self.value())
                if self.peek().kind == 'COMMA':
                    self.eat('COMMA'); continue
                break
        self.eat('RBRACK')
        return items

    def fields(self):
        fields = OrderedDict()
        if self.peek().kind == 'RBRACE':
            return fields
        while True:
            key = self.eat('IDENT').val
            self.eat('EQUAL')
            val = self.value()
            fields[key] = val
            if self.peek().kind == 'COMMA':
                self.eat('COMMA'); continue
            break
        return fields

# ─────────────────────── Pretty-printer ───────────────────────

def pp(val, indent=0, key=None, is_list_item=False):
    ind = '  ' * indent
    bullet = '- ' if is_list_item else ''
    if isinstance(val, Node):
        head = f"{val.name}"
        if key is not None and not is_list_item:
            print(f"{ind}{key}: {head}")
        else:
            print(f"{ind}{bullet}{head}")
        for k, v in val.fields.items():
            pp(v, indent + 1, key=k)
    elif isinstance(val, list):
        if key is not None and not is_list_item:
            print(f"{ind}{key}:")
            for item in val:
                pp(item, indent + 1, is_list_item=True)
        else:
            print(f"{ind}{bullet}[")
            for item in val:
                pp(item, indent + 1)
            print(f"{ind}]")
    else:
        out = repr(val) if isinstance(val, str) else str(val)
        if key is not None and not is_list_item:
            print(f"{ind}{key}: {out}")
        else:
            print(f"{ind}{bullet}{out}")

# ─────────────── Finder: harvest trees from any text ───────────────

_ident_then_brace = re.compile(r'([A-Za-z_][A-Za-z0-9_.]*)\s*\{')

def _find_matching_rbrace(s, i):
    """
    Given s and index i pointing at '{', return index of matching '}', or -1.
    Tracks single-quoted strings and backslash escapes; ignores braces inside strings.
    """
    assert 0 <= i < len(s) and s[i] == '{'
    depth = 0
    j = i
    in_str = False
    while j < len(s):
        ch = s[j]
        if in_str:
            if ch == '\\':
                j += 2; continue
            if ch == "'":
                in_str = False
            j += 1; continue
        # not in string
        if ch == "'":
            in_str = True; j += 1; continue
        if ch == '{':
            depth += 1
        elif ch == '}':
            depth -= 1
            if depth == 0:
                return j
        j += 1
    return -1  # unbalanced

def find_candidate_trees(text):
    """
    Yield (span_start, span_end, snippet) for each Ident{...balanced...} found.
    """
    for m in _ident_then_brace.finditer(text):
        name_start = m.start(1)
        brace_idx = m.end(0) - 1  # position of '{'
        end = _find_matching_rbrace(text, brace_idx)
        if end == -1:
            continue
        yield (name_start, end + 1, text[name_start:end + 1])

# ─────────────────────────── Main ────────────────────────────

def read_input():
    if not sys.stdin.isatty():
        return sys.stdin.read()
    if len(sys.argv) > 1:
        if sys.argv[1] == '-f' and len(sys.argv) > 2:
            with open(sys.argv[2], 'r', encoding='utf-8') as fh:
                return fh.read()
        return sys.argv[1]
    print("Usage:\n"
          "  echo \"...log... ToyBlockNode{...} ...\" | pretty_toy_ast.py\n"
          "  cat dump.txt | pretty_toy_ast.py\n"
          "  pretty_toy_ast.py \"ToyBlockNode{...}\"\n"
          "  pretty_toy_ast.py -f dump.txt",
          file=sys.stderr)
    sys.exit(1)


def main():
    data = read_input()
    found_any = False

    for _s, _e, snippet in find_candidate_trees(data):
        try:
            tree = Parser(Lexer(snippet).tokens()).parse()
        except Exception:
            continue  # skip non-parsable candidates

        # Only print roots that are ToyBlockNode
        if isinstance(tree, Node) and tree.name == 'ToyBlockNode':
            if found_any:
                print("\n" + "-" * 72 + "\n")
            found_any = True
            pp(tree)

    if not found_any:
        print("No ToyBlockNode trees found.", file=sys.stderr)
        sys.exit(2)


if __name__ == '__main__':
    main()
