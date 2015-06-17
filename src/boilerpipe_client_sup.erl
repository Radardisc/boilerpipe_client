%%% @author Rascerl <rascerl> 
%%% @since 
%%% @copyright 2013 Rascerl
%%% @doc 
%%% @end
-module(boilerpipe_client_sup).

-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).


init([]) ->
    NumClients = application:get_env(boilerpipe_client, num_clients, 10 ),
    CSpecs = [ boilerpipe_client_server:child_spec() ],
   {ok, { {one_for_one, 5, 10},  CSpecs  } }.




dispatch_server_pids() ->
    [ Pid || 
        { _, Pid , _ , [Module] } 
            <- 
            supervisor:which_children(?MODULE), 
            Module == boilerpipe_client_server, 
            is_pid(Pid) 
    ].
    