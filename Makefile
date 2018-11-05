build/%.o: %.asm
	nasm -f macho64 -o $@ $^

%: build/%.o
	ld $^ -o $@ -lSystem 

debug: numberparser
	lldb numberparser