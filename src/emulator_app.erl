-module(emulator_app).

-behaviour(application).

%% Application callbacks
-export([start/1, stop/1]).
-export([prepare/0, prepare/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(StartArgs) ->
  
	
   main_supervisor:start_link(StartArgs).

stop(_State) ->
    ok.

prepare()->prepare(32).

 
prepare(Num)->
	case global:whereis_name(tap_owner) of	
		undefined-> global:register_name(tap_owner,spawn(tap_owner,start,[Num]));
		X-> X!{restart,Num}
	end,
	ok.



