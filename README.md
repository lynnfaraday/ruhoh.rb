# My Ruhoh

This fork of the ruhoh blogging engine is for my fiddling with various 
features.  For more info, see:

<http://ruhoh.com>

Here are some of the features I'm working on:

## RSS Limit ((Pulled to Ruhoh Main))

A new config option allows you to limit the number of posts included in 
the RSS feed.  Default behavior is to include all posts.

    rss:
      limit: 10

## Widget Enhancements

### Widget Helpers

Widgets can now have Ruby helpers, which should be located in a 'helpers'
folder under the widget and named with the ".rb" extension.

    widgets
       my_widget
           helpers
           javascripts
           layouts

### Widget Context

Widget layouts now have access to the current page context, just like other 
layouts and partials.

Note: As a side effect of this, the special "{{config}}" that widgets
used to have passed directly is now part of the global payload under
"{{widgets.<widgetname>.config}}"

## Pagination

### Pagination Data

The global payload now includes pagination data {{pagination}}, which you can use to when formatting 
your index file.  

See [blog fork](https://github.com/lynnfaraday/blog/tree/pagination) for an example of usage.

### Pagination Files

The compiler step automatically renders your index.html file multiple times, once for each "page" of your index.
(The # of posts on each page is defined in the site config option posts/latest.)   

The first index file is placed in /index.html.
Subsequent index files are placed in /index/(page#)/index.html

# Comment Count widget

None of the comment modules currently support having multiple comment instances on a single page (like an
index page).  The comment count widget lets you display a hyperlink like "0 Comments" at the bottom of your post
summary, which will link to the main post's comment area.

    Usage:  
	{{{comments_count}}}

# Auto-Date Posts

You can use the {{DATE}} tag in the optional post name parameter when creating a new post.  For example:

    ruhoh draft "{{DATE}} My Post Title"

# Single Post Compile

The -p option on a compile will do a partial compile.  It does all the regular pages (since tags, recent posts, etc. will potentially be impacted) but will only touch the post specified.  This is especially useful when you're adding a new post.

    Usage:
    ruhoh compile -p untitled-1.md

