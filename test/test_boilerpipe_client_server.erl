-module(test_boilerpipe_client_server).

-include_lib("eunit/include/eunit.hrl").

-define(MOD, boilerpipe_client_server).


setup() -> 
    
    application:load(boilerpipe_client),
    application:set_env(boilerpipe_client,remote_server, { boilerpipe, ?MOD:nn_deduce(boilerpipe) } ),
    application:start(boilerpipe_client),
    
    ok.
teardown(_) -> 
    application:stop(boilerpipe_client).
    

boilerpipe_client_server_test_() ->
   {foreach, fun setup/0, fun teardown/1,
        [ 
            {timeout,30,fun run_direct/0}
        ] 
    }.
%%%.
run_direct() ->
    ?debugFmt("starting",[]),

    BadFile = filename:absname("../test/zh.html"),
    {error,{not_found, BadFile} } = ?MOD:parse(BadFile),
    
    GoodFile= filename:absname("../test_data/tele.html"),
      {ok, UrlText } = boilerpipe:parse(Url ),
    
    ?debugFmt("~p", [ filter(UrlText) ] ),
    ok.
    
    
filter(T) ->
    filter(T,[]).
    
filter([], Acc ) -> lists:reverse(Acc);
filter([H|T], Acc ) when H > 256 -> filter(T,Acc);
filter([H|T], Acc ) -> filter(T,[H|Acc] ).
