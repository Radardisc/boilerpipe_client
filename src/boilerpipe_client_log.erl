%%% @author Rascerl <rascerl> 
%%% @since 
%%% @copyright 2013 Rascerl
%%% @doc 
%%% @end

-module(boilerpipe_client_log).

-export([msg/2, warn/2, error/2]).


msg(Fmt, Args ) -> error_logger:info_msg("[boilerpipe_client] " ++ Fmt ++ "\n", Args).
warn(Fmt, Args ) -> error_logger:warning_msg("[boilerpipe_client] " ++ Fmt ++ "\n", Args).
error(Fmt, Args ) -> error_logger:error_msg("[boilerpipe_client] " ++ Fmt ++ "\n", Args).
