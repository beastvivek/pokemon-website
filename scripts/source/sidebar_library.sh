function anchor() {
  local reference=$1
  local class=$2
  local content=$3

  echo "<a href=\"${reference}.html\" class=\"${class}\">${content}</a>"
}

function generate_list_item() {
  local pokemon_type=$1

  local list_item=$( generate_tag "li" "list-item __${pokemon_type}__" "${pokemon_type}" )
  local anchor_tag=$( anchor "${pokemon_type}" "html-link" "${list_item}" )

  echo ${anchor_tag}
}

function generate_sidebar() {
  local pokemon_types=( $1 )
  local all_types=""

  for pokemon_type in ${pokemon_types[@]}
  do
    all_types=${all_types}$( generate_list_item "${pokemon_type}" )
  done
  
  local sidebar=$( generate_tag "aside" "sidebar" "${all_types}")

  echo ${sidebar}
}