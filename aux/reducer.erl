-module(reducer).
-export([start/0, init/0, start_link/0, reducer/0]).

start() ->
  Pid = spawn(reducer, init, []),
  Pid.

start_link() ->
  Pid = spawn_link(reducer, init, []),
  Pid.

init() ->
  timer:send_interval(10000, self(), flush),
  reducer().

reducer() ->
  reducer([]).
reducer(Queue) ->
  receive
    {add, Item} -> 
      io:format("ADD item ~p (count: ~p)~n", [Item, length(Queue)]),
      reducer(Queue++[Item]);
    flush ->
      io:format("--flushing--"),
      reducer([]);
    show ->
      lists:foreach(fun(El) -> io:format("~p~n", [El]) end, Queue),
      reducer(Queue)
  end.
