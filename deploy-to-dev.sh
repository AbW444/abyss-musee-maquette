#!/bin/bash
# Script pour finaliser la duplication vers dumbo-biovolume_DEV
# Prérequis : avoir un token GitHub (ghp_...) avec les droits repo
#
# Usage :
#   export GITHUB_TOKEN=ghp_votre_token_ici
#   bash deploy-to-dev.sh

set -e

GITHUB_USER="Holosene"
NEW_REPO="dumbo-biovolume_DEV"
DEV_DIR="/home/user/dumbo-biovolume_DEV"

if [ -z "$GITHUB_TOKEN" ]; then
  echo "Erreur : variable GITHUB_TOKEN non définie."
  echo "Exécutez : export GITHUB_TOKEN=ghp_votre_token_ici"
  exit 1
fi

echo "==> Création du repo distant $GITHUB_USER/$NEW_REPO sur GitHub..."
curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$NEW_REPO\",\"private\":false,\"description\":\"Version vitrine propre sans historique de développement\"}"

echo ""
echo "==> Push du contenu vers le nouveau repo..."
cd "$DEV_DIR"
git remote remove origin 2>/dev/null || true
git remote add origin "https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$NEW_REPO.git"
git push -u origin master

echo ""
echo "✓ Terminé ! Le repo est disponible sur https://github.com/$GITHUB_USER/$NEW_REPO"
