IF NOT EXIST output mkdir output
del /q output
copy source_rom\source_us.nes output\output_us.nes
copy source_rom\source_jp.nes output\output_jp.nes
tools\xkas -o output/output_us.nes src/main_us.asm
tools\xkas -o output/output_jp.nes src/main_jp.asm