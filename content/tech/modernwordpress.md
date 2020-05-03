---
title: "Modern Wordpress"
date: 2020-05-02T00:32:34Z
tags:
  - wordpress
  - php
  - blog
draft: false
---

A friend of mine works as a chiropractor and asked me if he could help maintain his company website.  Normally I would decline this kind of engagement, as I find it's difficult to mix business with friendship.  He is a close friend and a tennis doubles partner, so I thought I'd help him out.  It was a simple wordpress site after all! :)

Modern wordpress is much different then I remember it being the last time I worked with it.  Lots of really great plugins, a wonderful content management system, even a mobile editing app!  If my blog wasn't written in hugo, I'd consider using wordpress.  

You can feel a lot of the things that used to make wordpress feel cumbersome getting shaken out (mostly through plugins).  Wordpress also has a pretty vast theme ecosystem; webpages like [template monster](https://www.templatemonster.com/wordpress-themes.php) and the official [wordpress theme page](https://wordpress.org/themes/) have plenty of great themes to get you started for free or cheap.

There is now also [wp-cli](https://wp-cli.org/), which is a command line interface for a bunch of commonly used wordpress functionaity.  No more going into the database and editing an MD5sum'ed password in order to fix the inevitable lockout that you're going to give yourself after typing your password incorrectly.  I also very much appreciated that you could install wordpress plugins using this CLI, which is much better than opening up your server for FTP traffic to the public internet (this feels terrible; I'm not sure why this is still an option in 2020).

When I adopted this site, it was running on PHP5.6 on some unknown platform.  These freelance web developers were giving my friend a decent sized bill every month while adding questionable value.  I decided to move this blog to GCP in the transition.

GCE was the virtual machine platform of choice for this project, as I felt a single virtual machine was adequate for this blog (the SLA for this site is slightly different than others I've worked on).  I was also curious to see what a modern LAMP stack offers (we use PHP at work, but there are so many other pieces to an enterprise architecture these days).  I installed a fresh Ubuntu 20.04 LTS VM on the client's GCE instance, secured the site with a [LetsEncrypt](https://letsencrypt.org/) certificate, ran through the gauntlet of wordpress core and plugin updates, and was almost off to the races.

I realized that I needed to install a couple apache core updates:
- [mod_headers](https://httpd.apache.org/docs/current/mod/mod_headers.html) to set some Cache-Control headers
- [mod_expires](https://httpd.apache.org/docs/2.4/mod/mod_expires.html) for some legacy plugin Expires things
- [mod_rewrite](https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html).  Because wordpress normally lives on shared hosting, it heavily utilizes .htaccess, which makes content accessible with via this apache plugin.

I made an incremental and full backup (as a proper web maintainer always should do), performed the DNS migration from the old site to the new one, and I started saving my friend a bunch of cash every month (he was paying the previous maintainer to host it too).  GCE's snapshot tool is dead simple.  A couple clicks and I almost instantly have a backup to restore from if something goes awry during site maintenance.  A friendly reminder to always keep a physically distanced backup on a separate piece of hardware - this has saved me a couple times in the past.

I may decide to dockerize this blog in the near future, add varnish or a CDN, add autoscaling, integrate a WAF, et. al. - but I decided the juice wasn't worth the squeeze right now.  Might be a fun project in the future.  As my client is cost sensitive about his site (which many small business clients are), balancing optimization between functionality, reliability, availability, and price is always an interesting challenge.  Time is also a factor here - many of these optimizations would be nice, but they aren't needed currently.  We should always not attempt to prematurely optimize our projects, no matter how hard we get nerdsniped.
