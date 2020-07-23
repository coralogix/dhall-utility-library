#!/usr/bin/env bash

set -euo pipefail

echo '[INFO][dhall-types-svc][refreeze.sh] Refreezing...'
deepest_level=$(find . -name 'package.dhall' | sed 's/[^\/]//g' | awk '{ print length }' | sort | tail -n 1)
for depth in $(seq "${deepest_level}" -1 1) ; do
  while IFS= read -r -d '' dhall_file ; do
    echo "[INFO][dhall-aws][refreeze.sh] Freezing: ${dhall_file} ..."
    dhall freeze --cache --all --inplace "${dhall_file}"
  done < <(find . -mindepth "${depth}" -maxdepth "${depth}" -name 'package.dhall' -print0)
done
echo '[INFO][dhall-types-svc][refreeze.sh] Finished refreezing successfully!'
