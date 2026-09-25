# Spaces — code source

Application web d'esquisse de programme architectural : on saisit des surfaces et des
limites de côtés, l'application place les espaces sur une trame, et on les déplace,
tourne, fusionne et empile par niveaux.

## Contenu de l'archive

| Fichier | Rôle |
|---|---|
| `index.html` | **Toute l'application** : HTML, CSS, JavaScript et images, dans un seul fichier. Aucune dépendance, aucun serveur. |
| `logo/logo-original.jpeg` | Le logo d'origine tel que fourni. |
| `logo/mark.png`, `logo/wordmark.png` | Le logo découpé en deux (le symbole et le mot), fonds transparents. Ce sont ces deux images qui sont intégrées en base64 dans `index.html` et animées sur la page d'accueil. |

## Ouvrir l'application

Double-cliquer sur `index.html` : elle s'ouvre dans le navigateur et fonctionne hors ligne.

Pour entrer directement dans le plan sans passer par la page d'accueil, ajouter `#go` à
l'adresse : `index.html#go`.

## Mettre en ligne

C'est un fichier statique : il suffit de le déposer chez n'importe quel hébergeur
(GitHub Pages, Netlify, Cloudflare Pages, OVH, un dossier Apache/nginx…). Aucune base de
données ni backend n'est nécessaire.

## Deux valeurs à renseigner

Dans `index.html`, chercher `SITE_OWNER` (une seule occurrence) :

```js
const SITE_OWNER = '[your name or studio]';
const SITE_EMAIL = '[your@email]';
```

Tant qu'elles ne sont pas remplies, les pages À propos, Contact, Confidentialité et
Conditions affichent ces repères en orange.

## Où sont enregistrés les projets

- **Sur l'appareil**, dans le navigateur (IndexedDB, avec repli sur localStorage) :
  le travail en cours et les copies enregistrées. Rien n'est envoyé à un serveur.
- **Dans un fichier** : Home → Project → Download produit un `.json` que vous conservez,
  rechargeable par Open file…

Effacer les données du site dans le navigateur supprime le travail enregistré sur cet
appareil : pour tout ce qui compte, téléchargez le fichier de projet.

## Modifier le code

Le fichier est organisé en sections commentées, dans cet ordre : styles, balisage,
état et géométrie, rendu, panneaux, outils (Select, Move, Space, Marquee, Point, Line,
Merge, Rotate), import/export, page d'accueil et pages d'information.

Les images du logo sont intégrées en base64. Pour en changer, remplacer les deux
chaînes `data:image/png;base64,…` des balises `<img class="mark">` et
`<img class="word">` par les nouvelles images encodées, par exemple :

```bash
base64 -w0 logo/mark.png
```

## Licence

Aucune licence n'est fixée : le code vous appartient, à vous de choisir ce que vous
souhaitez en faire.
