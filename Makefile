X86_64_ASM_SRC_FILES := $(shell find src/x86_64 -name *.asm)
X86_64_ASM_OBJ_FILES := $(patsubst src/x86_64/%.asm, build/x86_64/%.o, $(X86_64_ASM_SRC_FILES))

.PHONY: build-x86_64
default: build-x86_64

$(X86_64_ASM_OBJ_FILES): build/x86_64/%.o: src/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64  $(patsubst build/x86_64/%.o, src/x86_64/%.asm, $@) -o $@

build-x86_64: $(X86_64_ASM_OBJ_FILES)
	mkdir -p dist/x86_64
	x86_64-elf-ld -n -o dist/x86_64/kernel.bin -T targets/x86_64/linker.ld $^
	cp dist/x86_64/kernel.bin targets/x86_64/iso/boot/kernel.bin
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso targets/x86_64/iso

clean:
	rm -rf build dist *.iso
