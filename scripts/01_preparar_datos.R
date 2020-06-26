########################
# 01_preparar datos    #
# Autor: JRR           #
# Manetenimiento: JRR  #
########################

# Paquetes ----------------------------------------------------------------
pacman::p_load(tidyverse, readxl, here, janitor)


# Cargar datos  -----------------------------------------------------------
fosas_guanajuato <- read_xlsx(here("data", "raw", "fosas_guanajuato_final.xlsx")) %>% 
      clean_names()

# Limpieza ----------------------------------------------------------------

limpieza_base <- function(bd) {
      bd %>% 
            select(-informacion_adicional, -condicion_de_los_cuerpos_encontrados_breve_descripcion_numero_sexo_etc) %>% 
            mutate(
                  ano = as.factor(ano),
                  fecha = as.Date(fecha),
                  entidad = as.factor(entidad),
                  clave_est = as.factor(clave_est),
                  clave_municipal = as.factor(clave_municipal),
                  municipio = as.factor(municipio),
                  cantidad_de_cuerpos_encontrados = as.numeric(cantidad_de_cuerpos_encontrados),
                  masculino = as.numeric(masculino), 
                  femenino = as.numeric(femenino)
                  )%>% 
            rename("total_cuerpos" = "cantidad_de_cuerpos_encontrados") %>% 
            mutate(cvegeo = paste0(clave_est, clave_municipal)) %>% 
            mutate(
                  cvegeo = as.factor(cvegeo)
            )
      }



fosas_guanajuato_final <- limpieza_base(bd = fosas_guanajuato)
                                                           
      
# Ahora arreglamos orden de columnas 
col_order <- c("ano", "fecha", "entidad", "clave_est", "municipio", "clave_municipal",
               "cvegeo","colonia_o_comunidad", "descripcion_geo", "fosas",
               "total_cuerpos", "masculino", "femenino", "links")

fosas_guanajuato_final <- fosas_guanajuato_final[, col_order] 


# Guardar base  -----------------------------------------------------------

write_rds(fosas_guanajuato_final,
          path = "data/clean/fosas_guanajuato_final.rds")

# Fin 
