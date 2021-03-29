-module(neam).
-export([hello/0]).
-compile(export_all).
-on_load(reload/0).

reload() -> ok.

hello() -> "World".
