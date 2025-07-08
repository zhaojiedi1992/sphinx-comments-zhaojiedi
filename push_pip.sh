#!/usr/bin/env bash
function update_version(){
  FILE="$1"
  version_string=$(grep -o 'version="[0-9]\+\.[0-9]\+\.[0-9]\+"' $FILE)
  version_number=$(echo $version_string | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
  IFS='.' read -r -a version_parts <<< "$version_number"
  new_patch_version=$((${version_parts[2]}+1))
  new_version="${version_parts[0]}.${version_parts[1]}.$new_patch_version"
  #sed -i "s@version=\"$version_number\"@version=\"$new_version\"@g" $FILE
  sed -i.bak "s@version=\"$version_number\"@version=\"$new_version\"@g" $FILE
}
update_version sphinx_comments_zhaojiedi/__init__.py
source .venv/bin/activate 2>/dev/null 
conda activate panda_python_kit 2>/dev/null


rm -rf dist
python3 -m build
twine upload  dist/*

git add . 
git commit -m "add"
git push