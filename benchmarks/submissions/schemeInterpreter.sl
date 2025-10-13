// Benchmark Simple scheme (like) interpreter
// This benchmark parses a small program that defines the fibonacci function
// and evaluates this to the 29th number, this does not sound all that impressive
// but this benchmarks encapsulates a lot of the languages features.


// make an array an list that keeps the size
function toList(arr) {
	list = new ();
	list.size = getSize(arr);
	i = 0;
	while(i < list.size) {
		list[i] = arr[i];
		i = i + 1;
	}
	return list;
}
function add(list, v) {
	list[list.size] = v;
	list.size = list.size + 1;
}
function copyList(list){
	n = new();
	n.size = list.size;
	i = 0;
	while(i < list.size) {
		n[i] = list[i];
		i = i + 1;
	}
	return n;
}
function pop(list) {
	if (list.size == 0) {
		println("Cannot pop from an empty list");
		return null();
	}
	val = list[0];
	i = 1;
	while(i < list.size) {
		list[i-1] = list[i];
		list[i] = null();
		i = i + 1;
	}
	list.size = list.size-1;
	return val;
}
function peek(list) {return list[0];}
function last(list) {return list[list.size-1];}

function listToStr(l) {
	str = "";
	i = 0;
	while(i < l.size) {
		str = str +l[i];
		if (i != l.size -1) {
			str = str + ", ";
		}
		i = i +1;
	}
	return str;
}


function toAtom(val) {
	res = toMap(new());
	res.t = "atom";
    	parsedInt = parseInt(val);
	// typeof and null comparison didnt work 
	// workaround: convert to string and match on NULL string
    	if (parsedInt +"" != "NULL") {
        	res.val = parsedInt;
        	res.vt = "int";
		return res;
	}
        res.val = val;
        res.vt = "symbol";
	return res;
}
function getValue(atom) {
	return atom.val;
}
function append(ls, i) {
	ls[getSize(ls)] = i;
}
function addSpaceToBracket(str) {
	result = "";
	s = getSize(str);
	i = 0;
	while (i < s-1) {
		b = subString(str, i, i+1);
		c = subString(str, i+1, i + 2);
		result = result + b;
		i = i + 1;
		if ((b == "(" && c != " ") ||  
		    (c == ")" && b != " ")) {
			result = result + " ";
		} 
		if (i == s - 1) { 
			result = result + c;
		}
	}
	return result;
}

function parse(src) {
	l = toList(stringSplit(addSpaceToBracket(src)));
	return parseTokens(l);
}

function parseTokens(tks) {
	top = pop(tks);
	if (top == "(") {
		subExpList = toList(new());
		subExpList.t = "list";
		while (peek(tks) != ")") {
			n = parseTokens(tks);
			add(subExpList, n);
		}
		pop(tks);
		return subExpList;
	} 
	if (top == ")") {
		println("weird");
		return;
	} 
	return toAtom(top);
}
function isDigit(c) {
	if (c == "1" || c == "2" || c == "3" || c == "4" || c == "5"	|| c == "6"
		|| c == "7" || c == "8"	|| c == "9" || c == "0") {
		return true;
	}
	return false;
}
function parseInt(str) {
	if (getSize(str) == 0 || isDigit(subString(str,0,1)) == false) {
		return null();
	}
	isNegative = false;
	if (subString(str, 0,1) == "-")  {
		isNegative = true;
		str = subString(str, 1,getSize(str)-1);
	}
	n = 0;
	i = 0;
    	while (i < getSize(str)) {
        	c = subString(str, i,i+1);
        	if (isDigit(c) == false) {
			return null();
        	}
        	n = (n * 10) + readDigit(c);
        	i = i + 1;
	}
	if (isNegative) {
        	return 0 - n;
    	}  
    	return  n;
}  
function readDigit(c) {
	if (c == "1") {	return 1; }
	if (c == "2") {	return 2; }
	if (c == "3") {	return 3; }
	if (c == "4") {	return 4; }
	if (c == "5") {	return 5; }
	if (c == "6") {	return 6; }
	if (c == "7") {	return 7; }
	if (c == "8") {	return 8; }
	if (c == "9") {	return 9; }
	if (c == "0") {	return 0; }
}

function benchmark() {
	defFib = "(define fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2))))))";
	src = "(begin "+defFib+" (fib 29))";
	ast = parse(src);
	expected = 514229;

	got = eval(ast, defaultEnv());
	if (got != expected) {
		println("Benchmark failed!");
	}
}
function main(){
	//
	// benchmark constants
	//
	ITERATIONS = 5000; // use 5000 iterations so we can up the number of fibonacci a bit
	MEASURE_FROM = 4000; 
	NAME = "Scheme interpreter";
	
	//
	// harness
	//
	time = 0;
	it = 0;
	
	while (it < ITERATIONS) {
		s = nanoTime();
		benchmark();
		e = nanoTime() - s;
		if (it >= MEASURE_FROM) {
		  time = time + e;
		}
		it = it + 1;
	}
	
	avg = time / (ITERATIONS - MEASURE_FROM);
	// Make sure you print the final result -- and no other things!
	println(NAME + ": " + avg);
}
function null() {}


// make an object a map
// this makes it so you can savely test is an object has a certain key
// also makes it that you can loop over each key
function toMap(obj){
	obj.keys = toList(new());
	return obj;
}
function keys(obj){
	return obj.keys;
}
function set(obj, key,val) {
	add(obj.keys, key); 
	obj[key]=val;
}
function get(obj, key) {
	return obj[key];
}
function hasKey(obj, key) {
	i = 0;
	while(i < obj.keys.size) {
		if (key == obj.keys[i]){
			return true;
		}
		i = i +1;
	}
	return false;
}

function defaultEnv() {
	env = toMap(new());
	// the parent field is used to scope variables,
	// when a lambda is used it needs its own scope
	// the 'child' env will have a ref to the parent
	env["__parent__"] = null();
	env["__function_cache__"] = toMap(new());
	set(env, "*", prelude_fn(prelude_mult));
	set(env, "+", prelude_fn(prelude_add));
	set(env, "/", prelude_fn(prelude_div));
	set(env, "-", prelude_fn(prelude_sub));
	set(env, "f", false);
	set(env, "t", true);
	set(env, "<",  prelude_fn(prelude_lt));
	set(env, "<=", prelude_fn(prelude_lte));
	set(env, ">",  prelude_fn(prelude_gt));
	set(env, ">=", prelude_fn(prelude_gte));
	set(env, "==", prelude_fn(prelude_eq));
	set(env, "!=", prelude_fn(prelude_neq));
	return env;
}
// a simple object is used for the function cache.
// keeps track of which functions and which input gave a certain result
function addToFunctionCache(env, func, vals, res) {
	str = func + "(" +listToStr(vals) + ")";
	set(env["__function_cache__"],str, res);
}
function tryGetFromCache(env, func, vals){
	str = func +"("+listToStr(vals)+")";
	if (hasKey(env["__function_cache__"], str)) {
		return get(env["__function_cache__"], str);
	}
	return null();
}

// recursively try to find the key
function getFromEnv(env,key){
	if(hasKey(env,key)){
		return get(env,key);
	}
	if (env["__parent__"] != null()){
		return getFromEnv(env["__parent__"],key);
	}
}
// make new child env
function newEnv(env, params, args) {
	newEnv = toMap(new());
	newEnv["__parent__"] = env;
	newEnv["__function_cache__"] = env["__function_cache__"];
	i = 0;
	while(i < params.size) {
		set(newEnv, params[i], args[i]);
		i = i + 1;
	}
	k = 0;
	return newEnv;
}

function eval(ast_,env) {
	if (ast_.t == "atom") {
		if (ast_.vt == "int") {	return ast_.val;	}
		if (ast_.vt == "symbol") {return getFromEnv(env,ast_.val);}
	}
	// copy the list of atoms, since popping can cause problems with the lambda definitions
	ast = copyList(ast_);
	top = pop(ast);
	if (top.val == "if") { return evalIf(ast,env);}
	if (top.val == "define") { return evalDefine(ast,env);}
	if (top.val == "lambda") { return evalLambda(ast,env);}
	if (top.val == "begin") {
		i = 0;
		while(i < ast.size) { 
			if (i == ast.size -1) {
				return eval(ast[i], env);
			}
			eval(ast[i], env); 
			i = i +1;
		}
	}
	fnObj = eval(top,env);
	if (fnObj.t == "lambda") {
		nlambda = copyLambda(fnObj);
		argList = toList(new ());
		i = 0;
		while(i < ast.size) { 
			add(argList,eval(ast[i], env)); 
			i = i +1;
		}
		cached = tryGetFromCache(env, top.val, argList);
		if (cached != null()){
			return cached;
		}
		paramsList = toList(new());
		i = 0;
		while(i < nlambda.params.size) {
			add(paramsList,getValue(nlambda.params[i]));
			i = i + 1;
		}
		newEnv = newEnv(env,paramsList, argList);
		res = eval(nlambda.body, newEnv);
		addToFunctionCache(env, top.val, argList,res);
		return res;
	} 
	if (fnObj.t == "function") {
		argList = toList(new ());
		i = 0;
		while(i < ast.size) { 
			add(argList,eval(ast[i], env)); 
			i = i +1;
		}
		return fnObj.fn(argList);
	}
}

function evalIf(ast, env) {
	cond = pop(ast);
	ten = pop(ast);
	els = pop(ast);
	if (eval(cond,env)){
		return eval(ten, env);
	}
	return eval(els,env);
}
function evalDefine(ast, env) {
	sym = pop(ast);
	def = pop(ast);
	set(env, sym.val,eval(def,env));
}
function evalLambda(ast, env) {
	l = new();
	l.params = pop(ast);
	l.body = pop(ast);
	l.t = "lambda";
	return l;	
}
function copyLambda(la) {
	l = new();
	l.params = copyList(la.params);
	l.body = copyList(la.body);
	l.params.t = "list";
	l.body.t = "list";
	l.t = la.t;
	return l;	

}
function prelude_fn(fn) {
	r = new();
	r.t = "function";
	r.prelude = "true";
	r.fn = fn;
	return r;
}

function prelude_math(atoms, op) {
	n = atoms[0];	i = 1; 
	while (i < atoms.size) {
		n = op(n, atoms[i]); 
		i = i + 1;
	}
	return n;
}
function m_add(x,y) 	{ return x + y;}
function m_sub(x,y) 	{ return x - y;}
function m_div(x,y) 	{ return x / y;}
function m_mult(x,y) 	{ return x * y;}

function prelude_add(atoms) 	{ return prelude_math(atoms, m_add);}
function prelude_div(atoms) 	{ return prelude_math(atoms, m_div);}
function prelude_mult(atoms) 	{return prelude_math(atoms, m_mult);}
function prelude_sub(atoms) 	{return prelude_math(atoms, m_sub);} 

// op needs to be the inverse of what should be tested;
function prelude_boolean(atoms,op) { 
	n = atoms[0];	i = 1; 
	while (i < atoms.size) {
		if (op(n,atoms[i])) {
			return false;
		}
		n = atoms[i]; 
		i = i + 1;
	}
	return true;
}

function lt(x,y) 	{return x < y;}
function eq(x,y) 	{return x == y;}
function neq(x,y) 	{return x != y;}
function gt(x,y) 	{return x > y;}
function gte(x,y) 	{return x >= y;}
function lte(x,y) 	{return x <= y;}

function prelude_gte(atoms) 	{ return prelude_boolean(atoms, lt);}
function prelude_gt(atoms) 	{ return prelude_boolean(atoms, lte);}
function prelude_eq(atoms) 	{ return prelude_boolean(atoms, neq);}
function prelude_neq(atoms) 	{ return prelude_boolean(atoms, eq);}
function prelude_lte(atoms) 	{ return prelude_boolean(atoms, gt);}
function prelude_lt(atoms) 	{ return prelude_boolean(atoms, gte);}


