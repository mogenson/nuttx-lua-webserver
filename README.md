# Nuttx Lua webserver

An HTTP webserver for [Nuttx](https://github.com/apache/incubator-nuttx).
Written in Lua and powered by [libuv](https://github.com/libuv/libuv). Uses
coroutines to respond to asynchronous requests.

Most of this code is copied from [Atlas](https://github.com/mblayman/atlas) and
trimmed down to fit a small embedded system running Nuttx. Atlas implements an
[ASGI](https://asgi.readthedocs.io/en/latest/index.html) architecture like
Python's [Django](https://www.djangoproject.com/) webserver. There is an `app`
directory that registers a set of functions to be called for each requested
route. The sever is in the `atlas` directory.

## Installation

Copy all source files to a permanent filesystem in your system, such as a SD
card.

## Usage

Run `lua start-server.lua`.

Modify the `config` variable in `start-server.lua` as desired.
