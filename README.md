# My Ruhoh

This fork of the ruhoh blogging engine is for my fiddling with various 
features.  For more info, see:

<http://ruhoh.com>

Here are some of the features I'm working on.  Breaking changes are highlighted in red.

## RSS Limit 
*Pulled to Ruhoh Main but not yet released.*

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

<font color="red">**Breaking Change**:</font> As a side effect of this, the special "{{config}}" that widgets
used to have passed directly is now part of the global payload under:

    {{widgets.<widgetname>.config}}

## Pagination

### Pagination Data

The compiler will automatically build paged index files - breaking up your blog into a pre-configured number of posts per page.  You can configure the page used as the base template for the paginated files.  Typically you'll want this to be your front page (index.html by default), but you can use any page.  This page will essentially be cloned multiple times - each time with *per_page* posts in the **page.pagination** payload.  

For example, if you have 10 total posts and 4 posts per page, your pagination would look like this:

   index.html  (base page, contains posts 1-4)
   /index/1/index.html   (1st index page, duplicate of base page)
   /index/2/index.html   (2nd index page, contains posts 5-8)
   /index/3/index.html   (3rd index page, contains posts 9-10)

Pagination data includes some top-level information:

   total_pages:  Number of pagination index pages
   total_posts:  Number of posts
   per_page:     The configured number of posts per index page
   index_pages:  Array containing the data for each index page

Each index page contains the following data:

   page_number:    User-friendly display number for the page
   posts:          Array of post ids for this page
   prev:           Array of up to 3 previous index pages (each containing "page_number" and "url")
   next:           Array of up to 3 next index pages (each containing "page_number" and "url")
   prev_truncated: If there are more than 3 previous pages, this is the URL of the 4th
   next_truncated: If there are more than 3 next pages, this is the URL of the 4th
      Note:  prev_truncated and next_truncated enable you to show a fast-forward arrow/button
   
### Configuration

In the main site config file:

    # config.yml
    ---
    pagination :
      base_page : index.html
      per_page : 10

### Example Usage

In the pagination base page:

    # index.html:
    ---
    {{# page.pagination.posts?to_posts}}
    	<br/><br/>
	    <div class="page-header">
	    <h1>{{ title }} {{# tagline }} <small>{{ . }}</small>{{/ tagline }}</h1>
	    </div>
	    {{{summary}}}
    {{/ page.pagination.posts?to_posts}}

	{{# page.pagination.prev}}
	    <a href="{{url}}">{{page_number}}</a>
	{{/ page.pagination.prev}}

	{{page.pagination.page_number}}

	{{# page.pagination.next}}
	    <a href="{{url}}">{{page_number}}</a>
	{{/ page.pagination.next}}


## Comment Count widget

None of the comment modules currently support having multiple comment instances on a single page (like an
index page).  The comment count widget lets you display a hyperlink like "0 Comments" at the bottom of your post
summary, which will link to the main post's comment area.

    Usage:  
	{{{comments_count}}}

## Auto-Date Posts

You can use the {{DATE}} tag in the optional post name parameter when creating a new post.  For example:

    ruhoh draft "{{DATE}} My Post Title"

## Compiler Options - Target Dir and Single Post

-p will do a partial compile.  It does all the regular pages (since tags, recent posts, etc. will potentially be impacted) but will only touch the post specified.  This is especially useful when you're adding a new post.

-t will set the target directory.

    Usage:
    ruhoh compile -p untitled-1.md -t output_dir

<font color="red">**Breaking Changes**:</font> 

* The target directory can no longer be passed directly to the compile command; use -t.
* The signature of a custom compiler's "run" method has changed to

     def self.run(target, opts) 

   The intent of this is as a stepping stone more flexible option parsing, if needed, though it isn't supported right now.
* Each compiler must generate its own 'Page' object (if it needs one); it is no longer passed in.

     page = Ruhoh::Page.new

## Publish Option

If you need to publish your compiled site to a server (as opposed to just pushing the git repo), the publish option is for you.  It will compile either the whole site or just a post (see Compiler Options, above), and then use *scp* to copy the results to your website.

    Usage:
    ruhoh publish -p untitled-1.md -t output_dir


### Configuration

In the main site config file:

	    # config.yml
	    ---
		publish:
		  host: www.site.com
		  root: /home/me/blog

## Miscellaneous

- Post scaffold has tags by default

