#!/bin/bash

echo "Fetching all branches"
git fetch --all

echo "Resetting to origin/main"
git reset --hard origin/main

echo "Restarting Varnish"
service varnish restart
