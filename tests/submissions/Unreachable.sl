

//other test

function test() {
	return;
	println("UNREACHABLE");
}

function main() {

	test();
	i = 0;
	while (i < 3) {
		i = i + 1;
		if (i == 1) {continue;}
		break;
		println("UNREACHABLE");
	}
	println(i);

}
