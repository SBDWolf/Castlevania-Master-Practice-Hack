IF NOT EXIST output mkdir output
del /q output
copy source_rom\source.nes output\output.nes
tools\xkas -o output/output.nes src/main.asm