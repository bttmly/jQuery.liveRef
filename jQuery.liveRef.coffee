do ( $ = jQuery ) ->

  ###
  attaching to $ instead of $.fn, since $.fn returns a jQuery object of the selector
  ###

  $.liveRef = ( selector ) ->
    splitted = selector
      .replace(RegExp(" > ", "g"), ">")
      .replace(RegExp(" >", "g"), ">")
      .replace(/> /g, ">")
      .replace(/>/g, "@>@")
      .replace(RegExp(" \\+ ", "g"), "+")
      .replace(RegExp(" \\+", "g"), "+")
      .replace(/\+ /g, "+")
      .replace(/\+/g, "@+@")
      .replace(RegExp(" ~ ", "g"), "~")
      .replace(RegExp(" ~", "g"), "~")
      .replace(/~ /g, "~")
      .replace(/~/g, "@~@")
      .replace(RegExp(" ", "g"), "@ @")
      .split("@")

    if splitted.length > 3

      jqlSelector = splitted.pop() 

      popped = splitted.pop()

      jqlOperator = switch
        when popped is " " then "find"
        when popped is "+" then "next"
        when popped is ">" then "children"
        when popped is "~" then "nextSiblings"

      $jqlStem = $(splitted.join(""))

    else if splitted length is 1
      jqlSelector = splitted[0]
      jqlOperator = "find"
      $jqlStem = $( "body" )

    return do ->
      $jqlStem[jqlOperator](jqlSelector)

  ### 
  quick and dirty.
  needs much more testing 
  this can probably be massively refactored and improved 
  ###

  $.fn.extend
    laterSiblings : ( selector ) ->
      context = this
      $parentChildren = this.parent().children()
      thisIndex = false
      matches = []
      $parentChildren.each ( i ) ->
        if context.is( $(this) )
          thisIndex = 8
        if thisIndex
          if selector
            if $( this ).is(selector)
              matches.push( $(this).not(context)[0] )
          else
            matches.push( $(this).not(context)[0] )
      matches.shift()
      return $(matches)

