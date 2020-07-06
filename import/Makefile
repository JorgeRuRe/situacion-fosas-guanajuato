# Authors:     OE
# Maintainers: OE, JRR
# Copyright:   2020, PDH-IBERO & Data Cívica, GPL v2 or later
# ===============================================
# situacion-fosas-guanajuato/import/Makefile

.PHONY: all clean

all: output/fosas-gto.rds \
	 output/preds-gto.rds

clean:
	rm output/*

output/fosas-gto.rds output/preds-gto.rds: \
		src/import.R \
		input/fosas_guanajuato_final.xlsx \
		input/preds-fosas-gto.csv
	Rscript --vanilla $<

# done.