
%%% @author Rascerl <rascerl>
%%% @copyright 2013 Rascerl
%%% @doc gen_server callback module implementation:

%%% @end
-module(boilerpipe_client_server).
-author('Rascerl <rascerl>').

-behaviour(gen_server).

-export([start_link/0,child_spec/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).
-export([code_change/3]).
-export([ terminate/2]).

-define(SERVER, ?MODULE).

-include("boilerpipe_client_log.hrl").

-export([parse/1,parse/2, nn_deduce/1]).

parse(FileName) -> gen_server:call(?MODULE, {parse,safe_string(FileName) } ).

parse(Pid, FileName) -> 
    gen_server:cast( ?MODULE, { parse, Pid, safe_string(FileName) } ).
    

safe_string(List) when is_list(List) -> List;
safe_string(Bin) when is_binary(Bin) -> binary_to_list(Bin).


child_spec() -> { 
    erlang:make_ref(),
    { ?MODULE,  start_link, [] },
    permanent,
    brutal_kill,
    worker,
    [?MODULE]}.
    
start_link() -> gen_server:start_link( {local,?MODULE},?MODULE, [], []).



ge(K,D) -> application:get_env(boilerpipe_client,K,D ).

nn_deduce(Atom) when is_atom(Atom) ->
    List=atom_to_list(Atom),
    case string:tokens(List,"@") of
        [ AtomString ] ->
            {ok, Host} = inet:gethostname() ,
            list_to_atom(AtomString++"@" ++ Host );
        _ ->
            Atom
    end.

init(_) ->
  {ok,  
    ge(remote_server, {boilerpipe, nn_deduce(boilerpipe) } ) % This should be { Name, Node }
  }.


handle_call({parse,FileName}, _From, ServerName) ->
    ?MSG("Parse ~s @ ~p", [ FileName, ServerName ] ), 
    ServerName ! { self(), FileName },
    Timeout = ge(timeout, 5000 ),
    receive
        Result ->
            { reply, Result, ServerName }
    after
        Timeout ->
            { reply, {error,Timeout}, ServerName }
    end;
handle_call(_Req, _From, State) ->
   {reply, State}.

handle_cast({parse,RequestPid, FileName}, ServerName) ->
     ?MSG("Parse ~s @ ~p", [ FileName, ServerName ] ), 
    ServerName ! { RequestPid, FileName },
    {noreply, ServerName};
handle_cast(_Req, State) ->
  {noreply, State}.

handle_info(_Info, State) -> 
  {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.


terminate(normal, _State) ->
  ok;
terminate(shutdown, _State) ->
  ok;
terminate({shutdown, _Reason}, _State) ->
  ok;
terminate(_Reason, _State) ->
  ok.
