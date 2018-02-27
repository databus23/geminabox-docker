#!/bin/sh

bundle exec puma -v --config /app/puma.rb /app/config.ru
