#!/usr/bin/env bash
set -euo pipefail

if ! command -v fzf &>/dev/null; then
  printf 'fzf is required. Install it first.\n' >&2
  exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
task_dir="${script_dir}/tasks"

mapfile -t task_scripts < <(find "${task_dir}" -maxdepth 1 -type f -name '*.sh' -print | sort)
if [[ ${#task_scripts[@]} -eq 0 ]]; then
  printf 'No installer scripts found in %s\n' "${task_dir}" >&2
  exit 1
fi

mapping_file="$(mktemp)"
trap 'rm -f "${mapping_file}"' EXIT

options=()
for script in "${task_scripts[@]}"; do
  name="$(basename "${script}" .sh)"
  description="$(grep -m1 '^# description:' "${script}" | sed 's/^# description:[[:space:]]*//')"
  if [[ -z "${description}" ]]; then
    description="(no description provided)"
  fi
  options+=( "${name}" )
  printf '%s\t%s\n' "${name}" "${description}" >> "${mapping_file}"
done

mapfile -t selections < <(
  printf '%s\n' "${options[@]}" |
    sort |
    fzf --multi \
        --prompt="Installers> " \
        --header="TAB mark, ENTER run, CTRL-A select all" \
        --preview="awk -F'\t' -v name={} '\$1==name {print \$2}' '${mapping_file}'" \
        --preview-window=down,wrap \
        --bind='ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all' || true
)

if [[ ${#selections[@]} -eq 0 ]]; then
  printf 'No installers selected. Exiting.\n'
  exit 0
fi

for entry in "${selections[@]}"; do
  script="${task_dir}/${entry}.sh"
  if [[ -x "${script}" ]]; then
    printf '\n==> Running %s\n' "${entry}"
    "${script}"
  else
    printf 'Missing installer script for %s\n' "${entry}" >&2
  fi
done
