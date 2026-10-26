# Game Boy Printer firmware (TMP87C840) - build from the editable source tree in src/
PY      ?= python3
ROM_MD5 := aa393ec87ccb4220200255ab5adf8ac9
SOURCES := $(wildcard src/*.asm src/*.inc src/data/*)

all: build/printer.bin

build/printer.bin: $(SOURCES) tools/t870asm.py tools/t870.py
	@$(PY) -c "import os; os.makedirs('build', exist_ok=True)"
	$(PY) tools/t870asm.py src/main.asm $@

# compare with the original ROM
check: build/printer.bin
	$(PY) tools/check_md5.py build/printer.bin $(ROM_MD5)

# regenerate the annotated listing from symbols/ (also reassembles it and checks the md5)
listing:
	$(PY) tools/build_listing.py

# regenerate src/ from the listing - OVERWRITES hand edits in src/
source: listing
	$(PY) tools/make_source.py

clean:
	$(PY) -c "import shutil; shutil.rmtree('build', ignore_errors=True)"

.PHONY: all check listing source clean
