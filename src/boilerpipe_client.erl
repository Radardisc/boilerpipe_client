%%% @author Rascerl <rascerl> 
%%% @since 
%%% @copyright 2013 Rascerl
%%% @doc 
%%% @end

-module(boilerpipe_client).

-export([start/0,stop/0]).

start() -> application:start(?MODULE).
stop() -> application:stop(?MODULE).
