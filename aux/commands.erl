-module(commands).
% -compile(export_all).
-import(reducer, [reducer/0]).
-export([start/0, map/2]).

start() ->
  Pid = spawn(?MODULE, init, []),
  Pid.

map(Command, Args) when Command =:= "ADD" ->
  % io:format("A!~n");
  reducer ! {add, Args};
map(Command, _Args) when Command =:= "SHOW" ->
  reducer ! show;
map(Command, _Args) ->
  io:format("wrong command ~p~n", [Command]).

init() ->
  loop().

loop() ->
  process_flag(trap_exit, true),
  Reducer = reducer:start_link(),
  register(reducer, Reducer),
  receive
    {'EXIT', Reducer, normal} -> ok;
    {'EXIT', Reducer, _} -> loop()
  end.
