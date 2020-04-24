---
title: "Nginx Logging"
date: 2020-04-23T02:22:08Z
draft: false
toc: false
images:
tags:
  - nginx
  - logging
  - jq
---

I wanted to be able to see my NGINX logs for this blog in JSON format, because I'm not sure were I'd like to eventually put them (perhaps [Elasticsearch](https://www.elastic.co/elasticsearch/).  It's also really nice to be able to read and grok logs quickly with [jq](https://stedolan.github.io/jq/).  I decided that this was easy enough to add in my logging.  In my nginx.conf (typically stored at `/etc/nginx/nginx.conf` in most linux distributions, you just need to change the default log location to be something similar to this:

```
log_format json_log '{ "time": "$time_iso8601", ' '"remote_addr": "$remote_addr", ' '"remote_user": "$remote_user", ' '"body_bytes_sent": "$body_bytes_sent", ' '"request_time": "$request_time", ' '"status": "$status", ' '"request": "$request", ' '"request_method": "$request_method", ' '"http_referrer": "$http_referer", ' '"http_user_agent": "$http_user_agent" }'; 

access_log /var/log/nginx/access.log json_log;
```

This now gives me readable, parsable logs via jq.

```
tail -f /var/log/nginx/access.log | jq .request
"GET /fonts/Inter-UI-Bold.woff2 HTTP/2.0"
"GET /fonts/Inter-UI-Regular.woff2 HTTP/2.0"
"GET /favicon.ico HTTP/2.0"
"GET / HTTP/2.0"
"GET /favicon.ico HTTP/2.0"
"GET /posts/ HTTP/2.0"
"GET /posts/ HTTP/2.0"
"GET /main.min.7bfbbe12786fa0ded4b4c0d792cbb36a5bd0bdb0b856dde57aa7b1f6fe0f2b87.css HTTP/2.0"
"GET /bundle.min.2d5469329143160ae2456a69c3c76dc2d0a3b212b46afe291a51bd68650ed6f8697e001dab54f1c272c77ce08092a8c55e5bb4314e0ee334aab4b927ec896638.js HTTP/2.0"
```

