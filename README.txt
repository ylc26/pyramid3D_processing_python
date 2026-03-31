G2
LOUAGUENOUNI Yanis
SLIMANI Mohamed Chakib

README - La Pyramide Mystérieuse (Projet Processing)

🎓 Présentation Générale
-------------------------
Ce projet consiste à explorer une pyramide mystérieuse composée de 5 étages de labyrinthes
générés procéduralement. Le joueur doit se frayer un chemin en évitant des momies errantes et
atteindre le trésor caché au plus profond du monument pour terminer l'aventure.
Vous avez à la fin des images à disposition pour illustrer le projet dans le fichier(README_IMAGES.pdf).

📖 Contexte Narratif
---------------------
Dans un désert perdu d’Égypte, une ancienne pyramide vient d’être découverte. Les explorateurs
racontent que quiconque y entre n’en ressort jamais. Vous incarnez un aventurier qui décide de s’y
aventurer à la recherche d’un trésor légendaire. Traversez les 5 étages, évitez les momies, et trouvez
le trésor doré pour espérer survivre

🧩 Fonctionnalités Clés
------------------------
• Labyrinthe/Pyramide procédural : Généré aléatoirement à chaque lancement.
• 5 étages de taille décroissante.
• Entrées et sorties dynamiques entre chaque niveau.
• Mini-carte mise à jour en temps réel.
• Mode perméable pour déboguer.
• Déplacement joueur fluide avec ZQSD.
• Momies avec comportement de poursuite aléatoire.
• IA simple pour les momies .
• Fin de jeu : trésor caché à une position aléatoire.
• Musique et ambiance sonore intégrées.
• Désert personnalisées autour de la pyramide.
• Textures dynamiques pour les murs, le sol et les décors.
• Code modulaire divisé en plusieurs fichiers (.pde) pour plus de lisibilité.
🎮 Commandes Utilisateur
-------------------------
- Z / Q / S / D : Se déplacer
- P : Ouvrir la porte principale
- J / K : Monter ou descendre d’un étage
- F : Activer le mode fantôme (perméable)
- Espace : Interagir avec le trésor (fin du jeu)
📁 Architecture du Projet
--------------------------
• main.pde : point d’entrée du jeu
• labyrinthe.pde : génération labyrinthe
• pyramide.pde : génération pyramide
• momie.pde : esthétique et déplacement
• desert.pde : génération désert
• controle.pde : gestion des entrées clavier
• utilitaires.pde : fonctions utilitaires (trésor, position aléatoire, boussole, etc./.)
• sketch.properties : configuration Processing
📷 Démonstration Attendues
---------------------------
• Exécution du jeu avec mini-map
• Explication du code
• Exploration des niveaux
• Rencontre des momies
• Atteinte du trésor
✅ État d’Avancement
---------------------
- [x] Génération procédurale des niveaux : Labyrinthe/Pyramide
- [x] Connexions dynamiques entre étages
- [x] Deux momies ennemies avec IA simple
- [x] Textures et modélisation 3D intégrées
- [x] Système sonore opérationnel
- [x] Mini-map interactive
- [x] Séparation claire du code par modules
- [x] Implémentation du mode débogage
- [x] Fin de jeu conditionnée par la découverte du trésor

Projet réalisé dans le cadre du cours IGSD.
