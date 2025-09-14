function main() {
	
	s4 = "yet another string";
	tokens = stringSplit(s4);
	println(getSize(tokens));

	i = getSize(tokens);
	while (i > 0) {
		i = i - 1;
		println(tokens[i]);
	}
	stringSplit(33);
}