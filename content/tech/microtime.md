---
title: "Microtime"
date: 2020-04-28T03:32:30Z
draft: false
---

I spent a lot of time tracking down a bug in some PHP microtime code today.  When reading microtime, one would think that it is time with microsecond precision. It often has more precision than that.  It is also critical to remember that `microtime()` returns an int, and `microtime(true)` returns a float

```
php > echo(microtime());
0.97812200 1588045939
php > echo(microtime(true));
1588045944.5691
php >
```

php also introduced `hrtime()` in PHP 7.3, which is a better option for a monotonic clock. 

https://www.php.net/manual/en/function.hrtime.php
