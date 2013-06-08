# My Ruhoh

This is a fork of the [Ruhoh blog engine](http://ruhoh.com).  I have extended the engine with several new features and plugins from my own blog.

# Status

**All features are now (hopefully!) fixed after the epic Ruhoh 2.1 merge.**

# Completed Features

These features are done but not merged to ruhoh main.

## Auto-Date Posts

Dates are automatically appended to post titles when creating a new post.

    ruhoh draft "My Post Title"  -->  2013-01-02 My Post Title

## Rake Install

Build and install the gem (locally) in one step - handy for gem development.

	rake install

## Photo Gallery Widget

Display a gallery of photos.  The two layouts it includes by default are [Popeye](http://dev.herr-schuessler.de/jquery/popeye/), a lightbox-style image gallery, and a simple table grid view.

*Note: This widget is available only in my fork of the [ruhoh blog scaffold](https://github.com/lynnfaraday/blog) because it requires javascripts and styling that doesn't fit nicely into the ruhoh engine.* 

###Configuration

In site config, select the popeye or grid layout.

	gallery:
     	use: popeye

###Usage:

In your blog post, include the gallery widget:

	{{{widgets.gallery}}}
	
In the page metadata, list the photo information under the 'gallery_photos' keyword:

	---
	title: Foo
	date: '2013-05-09'
	description:
	categories:
	tags: []
	gallery_photos:
	- enlarge_image_url: http://url.org/photo1_big.jpg
  	preview_image_url: http://url.org/photo1_small.jpg
  	view_url: http://url.org/photo.html
  	caption: My Caption 1
	- enlarge_image_url: http://url.org/photo2_big.jpg
  	preview_image_url: http://url.org/photo2_small.jpg
  	view_url: http://url.org/photo.html
  	caption: My Caption 2
	---

preview_image_url is the small image displayed at first, and enlarge_image_url is shown when the user clicks to enlarge the gallery view.  view_url and caption are shown in a link.

You can easily build the yaml metadata for a Flickr set using my [Flickr Badge Maker](https://github.com/lynnfaraday/Flickr_Badge_Maker) utility.

###Styling:

Grab the stylesheets, media and javascripts from the theme folder.

    lynn/javascripts/gallery
    lynn/stylesheets/gallery
    lynn/media/gallery

## Share This Widget

A widget using [Share This](http://sharethis.com/) to present the user with a bunch of options for sharing the post.

*Note: This widget is available only in my fork of the [ruhoh blog scaffold](https://github.com/lynnfaraday/blog) because there is no code involved.* 

### Configuration

You need to get your custom javascript from Share This.   You'll probably also want to tweak the layout. 

## Social Bar Widget

Shows social media icons where folks can follow you.

### Configuration

	use: social_bar

	"sites" : 
    	[    
    	{ "name": "RSS", "icon": "rss.jpg", "url": "/rss.xml"},
    	{ "name": "G+", "icon": "gplus.png", "url": "https://plus.google.com/youridhere"},
    	{ "name": "Facebook", "icon": "fb.png", "url": "http://www.facebook.com/yourfacebook"},
    	{ "name": "Flickr", "icon" : "flickr.png", "url": "http://flickr.com/yourflickr"},
    	]

### Styling

Be sure to grab the media from my fork of the [ruhoh blog scaffold](https://github.com/lynnfaraday/blog).


## Comments Count Widget

Shows a url like "0 comments" at the bottom of each post on your index page or paginated pages (since there's a known limitation with disqus and livefyre including them on a multi-post page).

Configuration:

    comments_count:
       use: disqus
       short_name: foo
       production_url: http://myurl
       # -- config for livefyre --
       # site_id: 123

    {{{widgets.comments_count}}}

# Merged Features

## Widget Context
*Merged to main, will be released in the next version*
Widget layouts now have access to the current page context.
	
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


