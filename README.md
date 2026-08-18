# Cartographie

Projet OCaml de visualisation de données cartographiques réalisé en classe préparatoire. Le programme lit des fichiers décrivant le réseau routier d'une ville ou d'un département (nœuds et segments) et l'affiche graphiquement à l'aide de la bibliothèque `graphics` d'OCaml.

![Carte de Rennes](images/rennes.png)

*Exemple : rendu du réseau routier de Rennes.*

## Fonctionnalités

- Modélisation d'un réseau cartographique sous forme de graphe (nœuds et arêtes)
- Lecture de fichiers de données représentant des villes ou des départements
- Affichage graphique interactif de la carte obtenue
- Distinction visuelle des différents types de voies (couleurs par catégorie : rues, routes principales, chemins, etc.)

## Structure du projet

```
Cartographie/
├── Node.mli / Node.ml              # Module de gestion des nœuds (intersections, points)
├── Edge.mli / Edge.ml              # Module de gestion des segments (routes reliant les nœuds)
├── Rasakumaran_Maps.ml              # Point d'entrée principal du programme
├── Rasakumaran_Maps2.ml
├── Rasakumaran_Maps3.ml
├── city_maps/                       # Fichiers de données des villes
├── department_maps/                 # Fichiers de données des départements
├── images/                          # Captures d'écran des cartes générées
├── Makefile
└── README.md
```

## Compilation

Le projet utilise `ocamlfind` avec le package `graphics` :

```bash
make
```

Cela génère l'exécutable `create_map`.

Pour nettoyer les fichiers compilés :

```bash
make clean
```

## Utilisation

L'exécutable prend en argument le nom d'une ville (ou d'un département) présente dans `city_maps/` ou `department_maps/` :

```bash
./create_map Rennes
```

Une fenêtre graphique s'ouvre alors et affiche la carte correspondante.

## Modules

- **Node** : représente les nœuds du graphe cartographique (coordonnées, identifiants).
- **Edge** : représente les segments reliant deux nœuds (routes, distances, catégories).

(Projet encore en amélioration , affichage des départements très prochainement)
