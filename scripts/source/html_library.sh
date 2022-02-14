source scripts/source/cards_library.sh
source scripts/source/sidebar_library.sh

function replace_text() {
  local to_replace=$1
  local replace_with=$2
  local base_text=$3

  sed "s;${to_replace};${replace_with};g" <<< "${base_text}"
}

function extract_types() {
  local pokemon_data=( $1 )
  local all_types=""

  for data in ${pokemon_data[@]}
  do
    all_types+=,$( get_pokemon_type "${data}" )
  done

  local pokemon_types=( $( tr "," "\n" <<< ${all_types} | sort | uniq ) )

  echo ${pokemon_types[*]}
}

function html() {
  local webpage_body=$1

  echo "<html><head><title>Pokemon</title><link rel=\"stylesheet\" href=\"css/styles.css\" /></head><body>${webpage_body}</body></html>"
}

function filter_data() {
  local pokemon_data=$1
  local pokemon_type=$2
  local old_IFS="${IFS}" 
  IFS=$' '

  grep "^.*|.*|.*${pokemon_type}" <<< ${pokemon_data}
  IFS="${old_IFS}"
} 

function generate_webpage() {
  local pokemon_data=$1
  local pokemon_type=$2
  local sidebar_block=$3

  local filtered_data=( $( filter_data "${pokemon_data}" "${pokemon_type}" ) )
  local selected_sidebar_block=$( sed "s;__${pokemon_type}__;${pokemon_type} selected;g" <<< "${sidebar_block}" ) 
  local all_cards=$( generate_pokemon_cards "${filtered_data[*]}" )
  
  if [[ ${pokemon_type} == "all" ]]
  then
    all_cards=$( generate_pokemon_cards "${pokemon_data}" )
  fi

  local webpage_body="${selected_sidebar_block}${all_cards}"
  local webpage_html=$( html "${webpage_body}" )

  echo ${webpage_html} 
}

function generate_webpages() {
  local html_dir_path=$1
  local pokemon_data=$2
  local pokemon_types=( $3 )
  local sidebar_block=$( generate_sidebar "${pokemon_types[*]}" )

  for pokemon_type in ${pokemon_types[@]}
  do 
    echo -n "${pokemon_type}.html is being generated... " 
    generate_webpage "${pokemon_data}" "${pokemon_type}" "${sidebar_block}" > ${html_dir_path}/${pokemon_type}.html
    echo " Created"
  done
}

function create_setup() {
  local resources_path=$1
  local data_file_path=$2
  local html_dir_path=$3

  rm -r ${html_dir_path} 2> /dev/null 
  mkdir -p ${html_dir_path}

  tar zxf ${resources_path}/images.tar.gz
  mv images ${html_dir_path}
  cp -r ${resources_path}/css ${html_dir_path}
}

function main() {
  local data_file_path=$1
  local html_dir_path=$2


  local pokemon_data=$( tail +2 ${data_file_path} )
  local pokemon_types=( all $( extract_types "${pokemon_data}" ) )

  echo "Generating Pokemon website..."

  generate_webpages "${html_dir_path}"  "${pokemon_data}" "${pokemon_types[*]}" 
}