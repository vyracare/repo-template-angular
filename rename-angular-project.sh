#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "❌ Uso: ./rename-angular-project.sh <novo-nome>"
  exit 1
fi

NEW_NAME=$1
GENERIC_NAME="\[nome-generico\]"

echo "🚀 Renomeando projeto para: $NEW_NAME"

# Arquivos principais
FILES=("angular.json" "package.json" "webpack.config.js" "nx.json" "tsconfig.json")

for FILE in "${FILES[@]}"; do
  if [ -f "$FILE" ]; then
    echo "📝 Atualizando $FILE..."
    sed -i "s/$GENERIC_NAME/$NEW_NAME/g" "$FILE"
  fi
done

# Pasta src/app (caso exista algo com [nome-generico])
if [ -d "src/app" ]; then
  find src/app -type f -exec sed -i "s/$GENERIC_NAME/$NEW_NAME/g" {} +
fi

# Renomear diretórios que usam [nome-generico]
if [ -d "projects/[nome-generico]" ]; then
  echo "📂 Renomeando pasta projects/[nome-generico] para projects/$NEW_NAME"
  mv "projects/[nome-generico]" "projects/$NEW_NAME"
fi

# Ajustar imports que referenciem [nome-generico]
grep -rl "\[nome-generico\]" . | while read -r file; do
  echo "🔍 Corrigindo import em $file"
  sed -i "s/$GENERIC_NAME/$NEW_NAME/g" "$file"
done

echo "✅ Projeto renomeado com sucesso para $NEW_NAME!"
