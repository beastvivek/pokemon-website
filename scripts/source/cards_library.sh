function capitalize_first_letter() {
  local word=$1

  local first_letter=${word:0:1}
  local rest_word=${word:1}
  local upper_case=$( tr [[:lower:]] [[:upper:]] <<< ${first_letter} )

  echo ${upper_case}${rest_word}
}

function generate_pokemon_type() {
  local pokemon_type="$1"
  local capital_pokemon_type=$( capitalize_first_letter "${pokemon_type}" )

  local type_div=$( div "${pokemon_type}" "${capital_pokemon_type}" )

  echo ${type_div}
}

function combine_pokemon_type() {
  local pokemon_type=( $1 )
  local pokemon_type_block=""

  for type in ${pokemon_type[@]}
  do
    pokemon_type_block="${pokemon_type_block}$( generate_pokemon_type ${type} )"
  done
  echo "${pokemon_type_block}"
}

function wrap_pokemon_type() {
  local pokemon_type="$1"
  local types=($(echo ${pokemon_type} | tr "," " "))
  
  echo "$( combine_pokemon_type "${types[*]}" )"
}

function img() {
  local source=$1
  local alternative=$2
  local img_title=$3

  echo "<img src=\"${source}\" alt=\"${alternative}\" title=\"${img_title}\">"
}

function generate_pokemon_image() {
  local pokemon_name=$1

  local image=$( img "images/${pokemon_name}.png" "${pokemon_name}" "${pokemon_name}" )
  local image_div=$( div "pokemon-image" "${image}" )

  echo ${image_div}
}

function generate_pokemon_details() {
  local pokemon_name=$1
  local pokemon_type=$2

  local pokemon_name=$( capitalize_first_letter ${pokemon_name} )
  local pokemon_type="$( wrap_pokemon_type "${pokemon_type}" "${type_template_path}" )"

  local name_heading=$( generate_tag "h2" "pokemon-name" "${pokemon_name}" )
  local type_div=$( div "pokemon-type" "${pokemon_type}" )
  
  local details_content="${name_heading}${type_div}"
  local details_div=$( div "pokemon-details" "${details_content}" )

  echo ${details_div}
}

function table() {
  local class=$1
  local content=$2

  echo "<table class=\"${class}\"><tbody>${content}</tbody></table>"
}

function table_row() {
  local row_head=$1
  local row_value=$2

  echo "<tr><td>${row_head}</td><td>${row_value}</td></tr>"
}

function generate_pokemon_attributes() {
  local speed=$1
  local hp=$2
  local basexp=$3
  local attack=$4
  local defense=$5
  local weight=$6

  local pokemon_attributes=( "Weight" "Base XP" "HP" "Attack" "Defense" "Speed")
  local attributes_value=( "$weight" "$basexp" "$hp" "$attack" "$defense" "$speed" )

  local index=0
  attributes_number=${#pokemon_attributes[@]}

  while [[ $index < ${attributes_number} ]]
  do
    table_content+=$( table_row "${pokemon_attributes[$index]}" "${attributes_value[$index]}" )
    index=$(( $index + 1 ))
  done

  local table=$( table "pokemon-attributes" "${table_content}" )
  local attributes_div=$( div "attributes-table" "${table}" )

  echo ${attributes_div}
}

function div_with_id(){
  local id=$1
  local class=$2
  local content=$3

  echo "<div id=\"${id}\" class=\"${class}\">${content}</div>"
}

function generate_pokemon_card() {
  local data=$1

  local pokemon_id=$( get_pokemon_id "${data}" )
  local pokemon_name=$( get_pokemon_name "${data}" )
  local pokemon_type=$( get_pokemon_type "${data}" )
  local speed=$( get_speed "${data}" )
  local hp=$( get_hp "${data}" )
  local basexp=$( get_basexp "${data}" )
  local attack=$( get_attack "${data}" )
  local defense=$( get_defense "${data}" )
  local weight=$( get_weight "${data}" )

  local image=$( generate_pokemon_image "${pokemon_name}" )
  local details=$( generate_pokemon_details "${pokemon_name}" "${pokemon_type}" )
  local attributes=$( generate_pokemon_attributes "${speed}" "${hp}" "${basexp}" "${attack}" "${defense}" "${weight}" )

  local card_content="${image}${details}${attributes}"
  local pokemon_card=$( div_with_id "${pokemon_id}" "pokemon-card" "${card_content}" )
 
  echo ${pokemon_card}
}

function generate_pokemon_cards() {
  local pokemon_data=( $1 )
  local all_cards=""

  for data in ${pokemon_data[@]}
  do
    all_cards=${all_cards}$( generate_pokemon_card "${data}" )
  done

  local cards_container=$( div "cards-container" "${all_cards}" )
  
  echo ${cards_container}
}