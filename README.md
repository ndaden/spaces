# Spaces — Plan d'étage & Esquisse de Programme Architectural

Application web d'esquisse de programme architectural conçue pour une utilisation rapide sur chantier : saisie des surfaces et limites, placement sur trame, déplacement, rotation, fusion et empilement par niveaux.

- **URL de production :** [spaces.dnabil.ovh](https://spaces.dnabil.ovh)
- **Image Docker :** `ghcr.io/ndaden/spaces:latest`
- **Documentation d'origine :** Voir [`LISEZMOI.md`](./LISEZMOI.md)
- **Spécification technique & Feuille de route :** Voir [`docs/superpowers/specs/2026-09-25-spaces-k3s-deployment-and-evolution-design.md`](./docs/superpowers/specs/2026-09-25-spaces-k3s-deployment-and-evolution-design.md)

---

## Fonctionnalités Clés

- **100% Fonctionnel Hors-ligne :** Aucune dépendance réseau, stockage local IndexedDB dans le navigateur.
- **Conçu pour le terrain / chantier :** Mode tactile optimisé mobile et tablette, menus escamotables, support multi-touch et stylet.
- **Moteur géométrique architectural :** Répulsion / glissement des cloisons mitoyennes (*push*), fusion de polygones, magnétisme intelligent.
- **Topographie & Niveaux :** Import Lambert (CSV/TSV), points de repère, gestion multi-étages et espaces communicants.
- **Export haute fidélité :** Export SVG vectoriel et PNG haute résolution avec densité DPI physique calculée à l'échelle.

---

## Déploiement sur Kubernetes (k3s)

Les manifests déclaratifs sont regroupés dans le dossier `k8s/` :

- `k8s/namespace.yaml` : Namespace dédié `spaces`
- `k8s/deployment.yaml` : Déploiement Nginx Alpine avec sondes `/healthz`
- `k8s/service.yaml` : Service ClusterIP
- `k8s/ingress.yaml` : Ingress Traefik avec terminaison TLS cert-manager (`letsencrypt-prod`)
- `k8s/kustomization.yaml` : Gestionnaire Kustomize

### Déployer sur le cluster

```bash
kubectl apply -k k8s/
```

### Vérifier le déploiement

```bash
kubectl get pods,svc,ingress -n spaces
```

---

## CI/CD Automatisé

À chaque commit poussé sur la branche `main`, le workflow GitHub Actions (`.github/workflows/deploy.yml`) :
1. Construit l'image Docker multi-architecture (`linux/amd64`, `linux/arm64`).
2. Publie l'image sur GitHub Container Registry : `ghcr.io/ndaden/spaces:latest`.

---

## Licence

Le code vous appartient, à vous de choisir ce que vous souhaitez en faire.
