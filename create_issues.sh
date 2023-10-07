#!/usr/bin/env bash

set -euo pipefail

echo "[INFO] Creating issues" >&2
while read -r repo; do
	if echo "$repo" | grep -f created_repos.txt > /dev/null; then
		echo "[INFO] Skipped creating an issue because it was already created to this repository  repo=$repo" >&2
		continue
	fi
	echo "[INFO] Creating an issue  repo=$repo" >&2
	sed "s|<package>|$repo|g" body.md |
		gh -R "$repo" issue create \
			-F - \
			-t "Add the installation guide with aqua to the document"
	echo "$repo" >> created_repos.txt
done < repos.txt
echo "[INFO] Completed creating issues" >&2
