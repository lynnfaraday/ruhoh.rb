## My Ruhoh

This fork of the ruhoh blogging engine is for my fiddling with various 
features.  For more info, see:

<http://ruhoh.com>

Here are some of the features I'm working on:

### RSS Limit

A new config option allows you to limit the number of posts included in 
the RSS feed.  Default behavior is to include all posts.

    rss:
      limit: 10

# Single Post Compile

The -p option on a compile will do a partial compile.  It does all the regular pages (since tags, recent posts, etc. will potentially be impacted) but will only touch the post specified.  This is especially useful when you're adding a new post.

    Usage:
    ruhoh compile -p untitled-1.md

