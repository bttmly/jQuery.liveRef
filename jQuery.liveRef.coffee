do ( $ = jQuery ) ->

  splitSelector = ( cssSelector ) ->
    return cssSelector
    .trim() # get rid of leading and trailing spaces
    .replace(/\s{2,}/g, ' ') # replace multiple consecutive spaces with a single space
    .replace(RegExp(" > ", "g"), ">") # "ul > li" becomes "ul>li"
    .replace(RegExp(" >", "g"), ">") # "ul >li" becomes "ul>li"
    .replace(/> /g, ">") # "ul> li" becomes "ul>li"
    .replace(/>/g, "✄>✄") # "ul>li" becomes "ul✄>✄li"
    .replace(RegExp(" \\+ ", "g"), "+") # "h1 + p" becomes "h1+p"
    .replace(RegExp(" \\+", "g"), "+") # "h1 +p" becomes "h1+p"
    .replace(/\+ /g, "+") # "h1+ p" becomes "h1+p"
    .replace(/\+/g, "✄+✄") # "h1+p" becomes "h1✄+✄p"
    .replace(RegExp(" ~ ", "g"), "~") # "h1 ~ h2" becomes "h1~h1"
    .replace(RegExp(" ~", "g"), "~") # "h1 ~h2" becomes "h1~h1"
    .replace(/~ /g, "~") # "h1~ h2" becomes "h1~h1"
    .replace(/~/g, "✄~✄") # "h1 ~ h2" becomes "h1✄~✄h1"
    .replace(RegExp(" ", "g"), "✄ ✄") # " " becomes "✄ ✄"
    .split("✄") # use ✄ as a delimiter. Each element in the resulting array will be either a selector or a combinator

  # attaching to $ instead of $.fn, since $.fn returns a jQuery object of the selector
  $.liveRef = ( selector ) ->

    splitted = splitSelector( selector )

    # in a valid selector, number of combinators + number of selectors should be odd.
    return false unless splitted.length % 2 is 1

    # hopefully we have a string something like ".product-item > .product-entry"
    # which yields [".product-item", ">", ".product-entry], an array with length = 3
    if splitted.length >= 3

      # last array item becomes the selector used as the method's argument
      liveRefSelector = splitted.pop() 

      # after popping once, the new last item should be the combinator
      # here we match methods to the appropriate combinator
      # there isn't a default jQuery method that matches ~, so a custom method is defined below
      combinator = splitted.pop()
      
      liveRefMethod = switch
        when combinator is " " then "find"
        when combinator is "+" then "next"
        when combinator is ">" then "children"
        when combinator is "~" then "laterSiblings"

      # the remainder of the array gets joined into a string
      # which is then used to get a jQuery object and cache it
      $liveRefcontext = $( splitted.join( "" ) )

    # if splitted doesn't have at least [context, combinator, selector]
    # then unless the original string was malformed, the array should have length = 1
    # use the first (and hopefully only) element as the selector
    # default to find as the method...
    # since we'll default to $("body") as the context
    else
      liveRefSelector = splitted[0]
      liveRefMethod = "find"
      $liveRefcontext = $( "body" )

    return ->
      $liveRefcontext[liveRefMethod]( liveRefSelector )

  # Quick and dirty. Needs testing.
  $.fn.extend
    laterSiblings : ( selector ) ->
      selector = selector or -> return true
      $parentChildren = this.parent().children()
      index = $parentChildren.index( this )
      return $parentChildren.slice( index ).filter( selector )

