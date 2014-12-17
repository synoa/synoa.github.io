# More Tags

WordPress has the ability to use a "more" Tag (`<!--more-->` inside the code or via GUI) to determine where to break
the string returned by `the_content()`. By default, this is not used on pages. To active it, add the following snippet
after `the_post()` has been called and before `the_content()` is first called.

```php
global $more // use global $more variable
$more = 0;

// real-code example:
<?php while ( $loop->have_posts() ) : $loop->the_post(); ?>
<?php 
global $more;
$more = 0;
?>
```

This way, More Tags can be used on pages.
