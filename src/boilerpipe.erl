%%% @author Rascerl <rascerl> 
%%% @since 
%%% @copyright 2013 Rascerl
%%% @doc 
%%% @end

-module(boilerpipe).

-export([parse/1]).


parse( FileName ) -> 
     Timeout = ge(timeout, 5000 ),
    Self = self(),
    boilerpipe_client_server:parse( Self, FileName ),
    
    receive
        Result ->
            Result
    after
        Timeout ->
            {error,timeout}
    end.
    
ge(K,D) -> application:get_env(boilerpipe_client,K,D ).