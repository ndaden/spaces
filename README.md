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

- `k8s/01-namespace.yaml` : Namespace dédié `spaces`
- `k8s/02-deployment.yaml` : Déploiement Nginx Alpine avec sondes `/healthz` et secret de pull GHCR
- `k8s/03-service.yaml` : Service ClusterIP port 80
- `k8s/04-ingressroute.yaml` : IngressRoute Traefik natif avec terminaison TLS cert-manager (`letsencrypt-prod`)

### Déployer manuellement sur le cluster

```bash
kubectl apply -f k8s/01-namespace.yaml
kubectl apply -f k8s/02-deployment.yaml
kubectl apply -f k8s/03-service.yaml
kubectl apply -f k8s/04-ingressroute.yaml
```

### Vérifier le déploiement

```bash
kubectl get pods,svc,ingressroute -n spaces
```

---

## CI/CD Automatisé & Déploiement Continu

À chaque commit poussé sur la branche `main` (ou via déclenchement manuel dans GitHub Actions), le workflow [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) (calqué sur le modèle de **Quizzy**) :
1. **Build & Publication :** Construit l'image Docker multi-architecture (`linux/amd64`, `linux/arm64`) et la pousse sur GitHub Container Registry (`ghcr.io/ndaden/spaces:${{ github.sha }}`).
2. **Déploiement sur le VPS :** Se connecte à votre cluster k3s à l'aide du secret `KUBECONFIG` (décodé en base64), applique les manifests K8s et redémarre le déploiement (`kubectl rollout restart deployment spaces -n spaces`).

### Configuration du Secret GitHub pour le déploiement automatique

Pour activer le déploiement automatique vers votre VPS, configurez le secret `KUBECONFIG` :

1. Sur votre VPS k3s, affichez le fichier kubeconfig en remplaçant `127.0.0.1` par l'IP publique ou le domaine de votre VPS :
   ```bash
   sudo cat /etc/rancher/k3s/k3s.yaml | sed "s/127.0.0.1/<VOTRE_IP_VPS>/"
   ```
2. Rendez-vous sur GitHub dans les paramètres de votre dépôt :
   `Settings` > `Secrets and variables` > `Actions` > `New repository secret`
3. Nom : `KUBECONFIG`
4. Valeur : Collez l'intégralité du résultat obtenu à l'étape 1.

---

## Licence

Le code vous appartient, à vous de choisir ce que vous souhaitez en faire.
