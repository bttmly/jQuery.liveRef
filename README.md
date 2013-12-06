jQuery.liveRef
==============

Get a live reference function instead of a static jQuery cached object.

Normally one would cache a jQuery reference to items for sale with something like `$products = $("#product-listing ul > li.single-product")`. But if the list is updated, that jQuery reference won't catch those new items.

Instead, you could use `$products = $.liveRef("#product-listing ul > li.single-product")`, which caches the "context" of the selector, then returns a function which selects the elements that match the original selector *at the time the function is called*. In this case, the context is `$("#product-listing ul")`. Each time `$products()` is called, you'll get the result of context.children("li.single-product"). The method ("children" in this case) depends on the final combinator in the original selector passed to liveRef (">" in this case). The descendant combinator uses .find(), the child combinator uses .children(), the adjacent sibling combinator uses .next(), and the general sibling combinator uses the .laterSiblings() custom method.