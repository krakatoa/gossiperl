#!/bin/bash

rebar create-app appid=gossiperl

mkdir rel
cd rel
rebar create-node nodeid=gossiperl

# EDIT THE reltool.config from:
#
# {app, gossiperl, [{mod_cond, app}, {incl_cond, include}]}
#
# to:
#
# {app, gossiperl, [{mod_cond, app}, {incl_cond, include}, {lib_dir, ".."}]}
