#!/bin/bash

git fetch --all
git reset --hard origin/master
service varnish restart
