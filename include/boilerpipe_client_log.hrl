
-define( MSG(Fmt,Args), boilerpipe_client_log:msg( "[~p] " ++ Fmt, [?MODULE|Args] ) ).
-define( WARN(Fmt,Args), boilerpipe_client_log:warn( "[~p] " ++ Fmt, [?MODULE|Args] ) ).
-define( ERROR(Fmt,Args), boilerpipe_client_log:error( "[~p] " ++ Fmt, [?MODULE|Args] ) ).


