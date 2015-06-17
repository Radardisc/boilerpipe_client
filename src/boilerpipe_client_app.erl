%%% @author Rascerl <rascerl> 
%%% @since 
%%% @copyright 2013 Rascerl
%%% @doc 
%%% @end

-module(boilerpipe_client_app).
-behaviour(application).

-export([start/2, stop/1]).
%%%.
%%%'   CALLBACKS
start(_StartType, _StartArgs) ->
  boilerpipe_client_sup:start_link().

stop(_State) ->
  ok.
