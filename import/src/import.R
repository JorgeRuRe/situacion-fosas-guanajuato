# Author: JRR
# Maintainers: JRR, OE
# Copyright:   2020, PDH-IBERO & Data Cívica, GPL v2 or later
# ===========================================================
# feminicidios-usaid/import/src/import.R

# Paquetes ----------------------------------------------------------------
pacman::p_load(tidyverse, readxl, here, janitor)

# Archivos  ---------------------------------------------------------------

files <- list(inp_fosas = here("import/input/fosas_guanajuato_final.xlsx"),
              inp_preds = here("import/input/preds-fosas-gto.csv"),
              out_fosas = here("import/output/fosas-gto.rds"),
              out_preds = here("import/output/preds-gto.rds"))

# Limpieza ----------------------------------------------------------------

keep_cols <- c("inegi", "year", "fecha", "entidad", "municipio",
               "colonia_o_comunidad", "descripcion_geo", "fosas",
               "total_cuerpos", "masculino", "femenino", "links")

clean_fosas <- function(files) {
      df <- read_xlsx(files$inp_fosas) %>% 
            clean_names() %>%
            mutate(ano = as.integer(ano),
                   fecha = as.Date(fecha),
                   entidad = as.character(entidad),
                   clave_est = as.character(clave_est),
                   clave_municipal = as.character(clave_municipal),
                   municipio = as.character(municipio),
                   cantidad_de_cuerpos_encontrados = as.integer(cantidad_de_cuerpos_encontrados),
                   masculino = as.integer(masculino), 
                   femenino = as.integer(femenino),
                   inegi = paste0(clave_est, clave_municipal))%>% 
            rename(total_cuerpos = cantidad_de_cuerpos_encontrados,
                   year = ano) %>%
            select(all_of(keep_cols))

      return(df)
}

main <- function(){
      print("working on fosas gto")
      fosas_gto <- clean_fosas(files)

      print("writing fosas gto")
      saveRDS(fosas_gto, files$out_fosas) 

      print("writing preds fosas gto")
      preds_gto <- read_csv(files$inp_preds)
      saveRDS(preds_gto, files$out_preds) 
}

main()

# done. 
