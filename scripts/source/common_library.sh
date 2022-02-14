function generate_tag() {
  local tag=$1
  local class=$2
  local content=$3

  echo "<$tag class=\"${class}\">${content}</${tag}>"
}

function div() {
  local class=$1
  local content=$2

  generate_tag "div" "${class}" "${content}"
}

function get_data() {
  local data="$1"
  local field=$2

  cut -d"|" -f${field} <<< ${data}
}

function get_pokemon_id() {
  local data=$1
  get_data ${data} 1
}

function get_pokemon_name() {
  local data=$1
  get_data ${data} 2
}

function get_pokemon_type() {
  local data=$1
  get_data ${data} 3
}

function get_speed() {
  local data=$1
  get_data ${data} 4
}

function get_hp() {
  local data=$1
  get_data ${data} 5
}

function get_basexp() {
  local data=$1
  get_data ${data} 6
}

function get_attack() {
  local data=$1
  get_data ${data} 7
}

function get_defense() {
  local data=$1
  get_data ${data} 8
}

function get_weight() {
  local data=$1
  get_data ${data} 9
}