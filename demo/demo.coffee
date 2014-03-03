$ ->

	$liveRef = $.liveRef ".with-plugin li"
	$vanillaRef = $ ".without-plugin li"

	$liveList = $ ".with-plugin ul"
	$vanillaList = $ ".without-plugin ul"

	$liveAdd = $ ".with-plugin .add-button"
	$vanillaAdd = $ ".without-plugin .add-button"

	$liveToggle = $ ".with-plugin .get-button"
	$vanillaToggle = $ ".without-plugin .get-button"

	listItem = $vanillaRef[0].outerHTML

	$liveAdd.on "click", ->
		$liveList.append $ listItem

	$vanillaAdd.on "click", ->
		$vanillaList.append $ listItem

	$liveToggle.on "click", ->
		$liveRef().toggleClass "halo"

	$vanillaToggle.on "click", ->
		$vanillaRef.toggleClass "halo"
