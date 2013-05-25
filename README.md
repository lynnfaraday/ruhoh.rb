# My Ruhoh

This fork of the ruhoh blogging engine is for my fiddling with various 
features.  For more info, see:

<http://ruhoh.com>

Here are some of the features in this fork.

**Note:  Due to the epic redesign for Ruhoh 2.1, a lot of the features broke and need to be redesigned as well.  The old stable version is still available on the 1.1 branch.**

# Completed Features

## Auto-Date Posts

You can use the {{DATE}} tag in the optional post name parameter when creating a new post.  For example:

    ruhoh draft "{{DATE}} My Post Title"

## Widget Context

Widget layouts now have access to the current page context via the *this_page* variable.

## Rake Install

Build and install the gem in one step - handy for gem development.

	rake install

# Features In Flux

## More Widget Context

**Broken by Ruhoh 2.1 redesign.  Investigating.**

Give widgets access to the current *post* and global site config.

## Comments Count Widget

**Broken due to lack of more widget context.**

Shows a url like "0 comments" at the bottom of each post on your index page or paginated pages (since there's a known limitation with disqus and livefyre including them on a multi-post page).

Configuration:

    comments_count:
       use: disqus
       short_name: foo
       production_url: http://myurl
       # -- config for livefyre --
       # site_id: 123

    {{{widgets.comments_count}}}

## Compiler Options - Target Dir and Single Post

**Broken by epic merge conflicts in Ruhoh 2.1 redesign.  Temporarily disabled while fixes are in progress.**

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

**Broken by epic merge conflicts in Ruhoh 2.1 redesign.  Temporarily disabled while fixes are in progress.**

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


# Merged Features

## RSS Limit 
*Released as of Ruhoh 2.1*
A new config option allows you to limit the number of posts included in the RSS feed.  

## Pagination
*Released as of Ruhoh 2.1*
Though not pulled directly, this functionality (a base index page showing the most recent posts) has been incorporated into the latest Ruhoh release.

## Post Tags
*Released as of Ruhoh 2.1*
Post scaffold has tags in it by default.

## Widget Helpers
*Made obsolete by Ruhoh 2.1*
This feature allowed widgets to have their own ruby files.  Using plugins is more in line with the Ruhoh architecture.


