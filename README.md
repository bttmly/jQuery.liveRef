jQuery.liveRef
==============

Get a live reference function instead of a static jQuery cached object.

Normally one would cache a jQuery reference to items for sale with something like `$products = $("#product-listing ul > li.single-product")`. But if the list is updated, that jQuery reference won't catch those new items.

`$products = $.liveRef("#product-listing ul > li.single-product")` caches the "stem" of the selector, then returns a function. In this case, the stem is $("#product-listing ul"). Each time `$products()` is called, you'll get the result of stem.children("li.single-product"). The operator ("children" in this case) depends on the final combinator in the original passed selector (">" in this case). The descendant combinator produces .find(), the child combinator uses .children(), the adjacent sibling combinator uses .next(), and the general sibling combinator uses the .laterSiblings() custom method.