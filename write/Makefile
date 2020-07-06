#
# Authors:     OE
# Maintainers: OE, JR
# Copyright:   2020, PDH-IBERI & Data Cívica, GPL v2 or later
# ===========================================================
# situacion-fosas-guanajuato/write/Makefile

HERE := $(shell git rev-parse --show-toplevel)

.PHONY: all clean

all: output/fosas-gto.html

clean: 
		-rm -r output/*

R_OPTS=--no-save --no-restore --no-init-file --no-site-file
KNIT="rmarkdown::render(input='$<', output_dir='output/')"

output/fosas-gto.html: \
		src/fosas-gto.Rmd
	Rscript $(R_OPTS) -e $(KNIT)

# done.