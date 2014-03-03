$ ->

	$liveRef = $.liveRef ".with-plugin li"
	$vanillaRef = $ ".without-plugin li"

	$liveList = $ ".with-plugin ul"
	$vanillaList = $ ".without-plugin ul"

	$liveAdd = $ ".with-plugin .add-button"
	$vanillaAdd = $ ".without-plugin .add-button"

	$liveToggle = $ ".with-plugin .get-button"
	$vanillaToggle = $ ".without-plugin .get-button"

	$listItem = $vanillaRef.eq(0).clone()

	$liveAdd.on "click", ->
		$liveList.append $listItem.clone()

	$vanillaAdd.on "click", ->
		$vanillaList.append $listItem.clone()

	$liveToggle.on "click", ->
		$liveRef().toggleClass "halo"

	$vanillaToggle.on "click", ->
		$vanillaRef.toggleClass "halo"

	$listItems = $( ".demo section" ).on "click", "li", ->
		$( this ).remove()