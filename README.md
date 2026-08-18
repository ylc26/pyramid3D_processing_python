# La Pyramide mystérieuse — jeu d’exploration 3D

Jeu d’exploration développé avec Processing en mode Java. Le joueur pénètre dans une pyramide composée de cinq étages de labyrinthes, évite des momies et cherche un trésor caché.

> Malgré le nom historique du dépôt, le projet utilise Processing en **mode Java**, et non le mode Python.

## Fonctionnalités

- pyramide et labyrinthes générés procéduralement ;
- cinq niveaux de taille décroissante ;
- passages dynamiques entre les étages ;
- exploration en vue 3D avec déplacements animés ;
- deux momies et comportement de poursuite simple ;
- boussole et mini-carte mises à jour en temps réel ;
- mode perméable pour le débogage ;
- textures, modèles 3D et ambiance sonore ;
- trésor déclenchant la fin de la partie.

## Structure du dépôt

```text
.
├── docs/
│   ├── demonstration.pdf            # Présentation illustrée du projet
│   └── notes_projet.txt             # Notes fonctionnelles d’origine
├── src/
│   └── pyramide_mysterieuse/        # Sketch Processing complet
│       ├── data/                     # Textures, audio et modèles 3D
│       ├── pyramide_mysterieuse.pde  # Point d’entrée
│       ├── controle.pde
│       ├── desert.pde
│       ├── labyrinthe.pde
│       ├── momie.pde
│       ├── pyramide.pde
│       └── utilitaires.pde
├── .gitignore
└── README.md
```

## Prérequis

- Processing 4 ;
- bibliothèque **Minim**, installable depuis le gestionnaire de bibliothèques de Processing.

## Lancement

1. Ouvrir `src/pyramide_mysterieuse/pyramide_mysterieuse.pde` dans Processing.
2. Vérifier que le sketch est en mode Java.
3. Installer Minim si nécessaire.
4. Cliquer sur **Run**.

Processing charge automatiquement les textures, modèles et fichiers audio présents dans le dossier `data/` du sketch.

## Commandes

| Touche | Action |
|---|---|
| `Z` | Avancer |
| `S` | Reculer |
| `Q` / `D` | Tourner à gauche / à droite |
| `J` / `K` | Monter / descendre à un passage |
| `P` | Revenir devant la pyramide et ouvrir le passage |
| `F` | Activer ou désactiver le mode perméable |
| Espace | Vérifier la présence du trésor |

## Démonstration

Une présentation illustrée du rendu, des niveaux et des fonctionnalités est disponible dans [docs/demonstration.pdf](docs/demonstration.pdf).

## Contexte

Projet universitaire réalisé dans le cadre de la Licence Informatique à l’Université Paris-Saclay.
