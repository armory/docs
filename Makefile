init: themes/docsy
	git submodule update --init --recursive
	
run: init
	hugo server -D