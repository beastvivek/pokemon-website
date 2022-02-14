#! /bin/bash
source scripts/test_scripts/test_report.sh
source scripts/source/html_library.sh
source scripts/source/cards_library.sh
source scripts/source/sidebar_library.sh
source scripts/source/common_library.sh

function test_generate_tag() {
  local tag="h1"
  local class="page-header"
  local content="Vivek Bisht is a bad boy"
  local test_description="Should generate the given tag"

  local expected="<h1 class=\"page-header\">Vivek Bisht is a bad boy</h1>"
  local actual=$( generate_tag "${tag}" "${class}" "${content}")

  test_heading "generate_tag"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_div() {
  local class="page-header"
  local content="Vivek Bisht is a bad boy"
  local test_description="Should generate a div tag"

  local expected="<div class=\"page-header\">Vivek Bisht is a bad boy</div>"
  local actual=$( div "${class}" "${content}")

  test_heading "div"
  assert_expectation "${expected}" "${actual}" "${test_description}"

}

function test_img() {
  local source="image.png"
  local alternative="image"
  local img_title="image"
  local test_description="Should give a image tag"

  local expected="<img src=\"image.png\" alt=\"image\" title=\"image\">"
  local actual=$( img ${source} ${alternative} ${img_title})

  test_heading "img"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_get_data() {
  local data="1|Bulbasaur|grass,poison"
  local field=3
  local test_description="Should give the data of the required field"

  local expected="grass,poison"
  local actual=$( get_data ${data} ${field} )

  test_heading "get_data"

  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_capitalize_first_letter() {
  local word="bulbasaur"
  local test_description="Should give the capitalized first letter"

  local expected="Bulbasaur"
  local actual=$( capitalize_first_letter ${word} )

  test_heading "capitalize_first_letter"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_replace_text() {
  local to_replace="__weight__"
  local replace_with="56kg"
  local base_text="My weight is __weight__"
  local test_description="Should find and replace required word in the given text"

  local expected="My weight is 56kg"
  local actual="$( replace_text "${to_replace}" "${replace_with}" "${base_text}" )"

  test_heading "replace_text"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_pokemon_type() {
  local pokemon_type="grass"
  local test_description="Should generate a div with a class of type"

  local expected='<div class="grass">Grass</div>'
  local actual="$( generate_pokemon_type "${pokemon_type}" )"

  test_heading "generate_pokemon_type"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_one_pokemon_type() {
  local pokemon_type=("grass")
  local test_description="Should generate one div when one type is given"

  local expected='<div class="grass">Grass</div>'
  local actual="$( combine_pokemon_type "${pokemon_type[*]}" )"

  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_more_than_one_pokemon_type() {
  local pokemon_type=("grass" "poison")
  local test_description="Should generate more than one div when multiple types are given"

  local expected='<div class="grass">Grass</div><div class="poison">Poison</div>'
  local actual="$( combine_pokemon_type "${pokemon_type[*]}" )"

  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_combine_pokemon_type(){
  test_heading "combine_pokemon_type"
  test_one_pokemon_type
  test_more_than_one_pokemon_type
}

function test_wrap_pokemon_type() {
  local pokemon_type="grass,poison"
  local test_description="Should generate the div block"

  local expected='<div class="grass">Grass</div><div class="poison">Poison</div>'
  local actual="$( wrap_pokemon_type "${pokemon_type}" )"

  test_heading "wrap_pokemon_type"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_pokemon_image() {
  local pokemon_name="bulbasaur"
  local test_description="Should generate the image block"

  local expected='<div class="pokemon-image"><img src="images/bulbasaur.png" alt="bulbasaur" title="bulbasaur"></div>'
  local actual=$( generate_pokemon_image "${pokemon_name}" )

  test_heading "generate_pokemon_image"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_pokemon_details() {
  local pokemon_name="Bulbasaur"
  local pokemon_type="grass,poison"
  local test_description="Should generate the details block"

  local expected='<div class="pokemon-details"><h2 class="pokemon-name">Bulbasaur</h2><div class="pokemon-type"><div class="grass">Grass</div><div class="poison">Poison</div></div></div>'
  local actual=$( generate_pokemon_details "${pokemon_name}" "${pokemon_type}" )

  test_heading "generate_pokemon_details"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_pokemon_attributes() {
  local speed=45
  local hp=45
  local basexp=64
  local attack=49
  local defense=49
  local weight=69
  local attributes_template_path="../../template/pokemon_attributes.html"
  local test_description="Should generate the attributes table"

  local expected='<div class="attributes-table"><table class="pokemon-attributes"><tbody><tr><td>Weight</td><td>69</td></tr><tr><td>Base XP</td><td>64</td></tr><tr><td>HP</td><td>45</td></tr><tr><td>Attack</td><td>49</td></tr><tr><td>Defense</td><td>49</td></tr><tr><td>Speed</td><td>45</td></tr></tbody></table></div>'
  local actual=$( generate_pokemon_attributes "${speed}" "${hp}" "${basexp}" "${attack}" "${defense}" "${weight}" ${attributes_template_path} )

  test_heading "generate_pokemon_attributes"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_pokemon_card() {
  local data="1|bulbasaur|grass,poison|45|45|64|49|49|69"
  local attributes_template_path="../../template/pokemon_attributes.html"
  local test_description="Should generate a pokemon card"

  local expected='<div id="1" class="pokemon-card"><div class="pokemon-image"><img src="images/bulbasaur.png" alt="bulbasaur" title="bulbasaur"></div><div class="pokemon-details"><h2 class="pokemon-name">Bulbasaur</h2><div class="pokemon-type"><div class="grass">Grass</div><div class="poison">Poison</div></div></div><div class="attributes-table"><table class="pokemon-attributes"><tbody><tr><td>Weight</td><td>69</td></tr><tr><td>Base XP</td><td>64</td></tr><tr><td>HP</td><td>45</td></tr><tr><td>Attack</td><td>49</td></tr><tr><td>Defense</td><td>49</td></tr><tr><td>Speed</td><td>45</td></tr></tbody></table></div></div>'
  local actual=$( generate_pokemon_card "${data}" "${attributes_template_path}" )

  test_heading "generate_pokemon_card"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_pokemon_cards() {
  local pokemon_data="1|bulbasaur|grass,poison|45|45|64|49|49|69
2|ivysaur|grass,poison|45|45|64|49|49|69"
  local attributes_template_path="../../template/pokemon_attributes.html"
  local test_description="Should generate all cards"

  local expected='<div class="cards-container"><div id="1" class="pokemon-card"><div class="pokemon-image"><img src="images/bulbasaur.png" alt="bulbasaur" title="bulbasaur"></div><div class="pokemon-details"><h2 class="pokemon-name">Bulbasaur</h2><div class="pokemon-type"><div class="grass">Grass</div><div class="poison">Poison</div></div></div><div class="attributes-table"><table class="pokemon-attributes"><tbody><tr><td>Weight</td><td>69</td></tr><tr><td>Base XP</td><td>64</td></tr><tr><td>HP</td><td>45</td></tr><tr><td>Attack</td><td>49</td></tr><tr><td>Defense</td><td>49</td></tr><tr><td>Speed</td><td>45</td></tr></tbody></table></div></div><div id="2" class="pokemon-card"><div class="pokemon-image"><img src="images/ivysaur.png" alt="ivysaur" title="ivysaur"></div><div class="pokemon-details"><h2 class="pokemon-name">Ivysaur</h2><div class="pokemon-type"><div class="grass">Grass</div><div class="poison">Poison</div></div></div><div class="attributes-table"><table class="pokemon-attributes"><tbody><tr><td>Weight</td><td>69</td></tr><tr><td>Base XP</td><td>64</td></tr><tr><td>HP</td><td>45</td></tr><tr><td>Attack</td><td>49</td></tr><tr><td>Defense</td><td>49</td></tr><tr><td>Speed</td><td>45</td></tr></tbody></table></div></div></div>'

  local actual=$( generate_pokemon_cards "${pokemon_data}" "${attributes_template_path}" )

  test_heading "generate_pokemon_cards"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_list_item() {
  local pokemon_type="grass"
  local test_description="Should generate list item of the type"

  local expected='<a href="grass.html" class="html-link"><li class="list-item __grass__">grass</li></a>'
  local actual=$( generate_list_item "${pokemon_type}" )

  test_heading "generate_list_item"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_generate_sidebar() {
  local pokemon_types=( "grass" "poison" "bug")
  local test_description="Should generate list of all types of pokemon"

  local expected='<aside class="sidebar"><a href="grass.html" class="html-link"><li class="list-item __grass__">grass</li></a><a href="poison.html" class="html-link"><li class="list-item __poison__">poison</li></a><a href="bug.html" class="html-link"><li class="list-item __bug__">bug</li></a></aside>'
  local actual=$( generate_sidebar "${pokemon_types[*]}" )

  test_heading "generate_sidebar"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_extract_types() {
  local pokemon_data="1|bulbasaur|poison,grass|45|45|64|49|49|69
2|ivysaur|grass,bug|45|45|64|49|49|69"
  local test_description="Should give array with all types of pokemon"

  local expected="bug grass poison"
  local actual=$( extract_types "${pokemon_data}" )

  test_heading "extract_types"
  assert_expectation "${expected}" "${actual}" "${test_description}"
}

function test_pokemon_card() {
  test_generate_tag
  test_div
  test_img
  test_get_data
  test_capitalize_first_letter
  test_replace_text
  test_generate_pokemon_type
  test_combine_pokemon_type
  test_wrap_pokemon_type
  test_generate_pokemon_image
  test_generate_pokemon_details
  test_generate_pokemon_attributes
  test_generate_pokemon_card
  test_generate_pokemon_cards
  test_generate_list_item
  test_generate_sidebar
  test_extract_types
}

test_pokemon_card
display_failed_tests
display_test_report