# nous allons creer une carte de la malnutrition en mauritanie 
# realiser par : Abdourahim Dia 

# Création du fichier de données sur la malnutrition----
data_malnutrition <- data.frame(
  region = c("Hodh ech Chargui", "Hodh el Gharbi", "Assaba", "Gorgol", "Brakna",
             "Trarza", "Adrar", "Tiris Zemmour", "Inchiri", "Nouakchott"),
  malnutrition = c(25, 22, 18, 20, 17, 15, 10, 8, 9, 12)
)

write.csv(data_malnutrition, "malnutrition.csv", row.names = FALSE)
cat("✅ Fichier 'malnutrition.csv' créé avec succès dans ton dossier de travail !")

# PREPARATION DE LA CARTE ----

install.packages(c("sf", "tmap", "ggplot2", "leaflet"))

#Ces packages servent à :
  
#sf : gérer les données spatiales (shape files, GeoJSON, etc.)----

#tmap : créer de jolies cartes statiques ou interactives----

#ggplot2 : pour des cartes stylisées (type graphique)----

#leaflet : pour des cartes interactives dynamiques----
  
  #puis les charger avec fonction library
  
library(sf)
library(tmap)
library(dplyr)
library(rnaturalearth)
library(rnaturalearthdata)

#Charger la carte du monde et filtrer la Mauritanie----

mauritanie <- ne_states(country = "Mauritania", returnclass = "sf")

# verifier ----

plot(mauritanie["name"])



# maintenant la carte est bien realiser----
cat("✅ Carte de la Mauritanie chargée avec succès !")




# Charger les données ----
data <- read.csv("malnutrition.csv")

#Fusionner les taux avec la carte

mauritanie_data <- mauritanie %>%
  left_join(data, by = c("name" = "region"))

# Créer la carte
tmap_mode("plot")
tm_shape(mauritanie_data) +
  tm_polygons("malnutrition",
              title = "Taux de malnutrition (%)",
              palette = "YlOrRd",
              style = "quantile") +
  tm_layout(title = "Carte de la malnutrition en Mauritanie REALISER par Abdourahim dia",
            frame = FALSE)
# Créer la carte optionnelle ( pour zoomer )

tmap_mode("view")
tm_shape(mauritanie_data) +
  tm_polygons("malnutrition",
              palette = "YlOrRd",
              title = "Taux de malnutrition (%)")