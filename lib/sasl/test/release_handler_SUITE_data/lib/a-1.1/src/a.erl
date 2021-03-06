%% ``The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved via the world wide web at http://www.erlang.org/.
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%%
%% The Initial Developer of the Original Code is Ericsson Utvecklings AB.
%% Portions created by Ericsson are Copyright 1999, Ericsson Utvecklings
%% AB. All Rights Reserved.''
%%
%%     $Id$
%%
-module(a).


-behaviour(gen_server).

%% External exports
-export([start_link/0, a/0, b/0]).
%% Internal exports
-export([init/1, handle_call/3, handle_info/2, terminate/2, code_change/3]).

start_link() -> gen_server:start_link({local, aa}, a, [], []).

a() -> gen_server:call(aa, a).
b() -> gen_server:call(aa, b).

%%-----------------------------------------------------------------
%% Callback functions from gen_server
%%-----------------------------------------------------------------
init([]) ->
    process_flag(trap_exit, true),
    {ok, {state, bval}}.

handle_call(a, _From, State) ->
    X = application:get_all_env(a),
    {reply, X, State};

handle_call(b, _From, State) ->
    {reply, {ok, element(2, State)}, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(1, Extra, State) ->
    {ok, {state, bval}};
code_change({down,1},Extra,State) ->
    {ok, state}.
