#!/usr/bin/env bash
set -eu

exe=${1:?First argument must be the executable to test}

root="$(cd "${0%/*}" && pwd)"
# shellcheck disable=1090
source "$root/utilities.sh"

SUCCESSFULLY=0

find ./tests/samples -type f -name '*.in' \
| while read -r file; do
  (with "input $file"
    answerFile="${file%.*}"
    it "succeeds with the correct answer" && {
      WITH_SNAPSHOT="${answerFile}.ans" \
      expect_run ${SUCCESSFULLY} "$exe" < "$file"
    }
  )
done
