-module(server_tests).
-author("Janusz").
-include_lib("eunit/include/eunit.hrl").

%% API
-export([]).

server_start_test() ->
  {true, ok} = {server:start(), server:stop()}.

server_adds_new_station_test() ->
  server:start(),
  {ok, ok} = {server:addStation("aaa", {1,3}), server:stop()}.

server_adds_measurement_test() ->
  server:start(),
  server:addStation("aaa", {1,3}),
  {ok, {{{2000, 10, 10},{10, 10, 10}}, "PM-10", 100 }, ok} = { server:addValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10", 100), server:getLastMeasurement("aaa", "PM-10"), server:stop()}.

server_deletes_measurement_test() ->
  server:start(),
  server:addStation("aaa", {1,3}),
  server:addValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10", 100),
  {ok, null,  ok} = {server:removeValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10"), server:getLastMeasurement("aaa", "PM-10") , server:stop()}.

server_get_one_value_test() ->
  server:start(),
  server:addStation("aaa", {1,3}),
  server:addValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10", 100),
  {100, ok} = {server:getOneValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10"), server:stop()}.

server_get_station_mean_test() ->
  server:start(),
  server:addStation("aaa", {1,3}),
  server:addValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10", 100),
  server:addValue("aaa", {{2000, 10, 10},{10, 12, 10}}, "PM-10", 50),
  {75.0, ok} = {server:getStationMean("aaa", "PM-10"), server:stop()}.

server_get_daily_mean_test() ->
  server:start(),
  server:addStation("aaa", {1,3}),
  server:addValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10", 100),
  server:addValue("aaa", {{2000, 10, 10},{10, 12, 10}}, "PM-10", 50),
  server:addValue("aaa", {{2000, 10, 10},{9, 12, 10}}, "PM-10", 30),
  server:addValue("aaa", {{2000, 11, 10},{9, 12, 10}}, "PM-10", 30),
  {60.0, ok} = {server:getDailyMean({2000, 10,10}, "PM-10"), server:stop()}.

server_get_hourly_mean_test() ->
  server:start(),
  server:addStation("aaa", {1,3}),
  server:addValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10", 100),
  server:addValue("aaa", {{2000, 11, 10},{10, 10, 10}}, "PM-10", 50),
  server:addValue("aaa", {{2000, 10, 10},{9, 12, 10}}, "PM-10", 30),
  server:addValue("aaa", {{2000, 11, 10},{9, 12, 10}}, "PM-10", 30),
  {75.0, ok} = {server:getHourlyMean("aaa", {10,10,10}, "PM-10"), server:stop()}.

server_get_measure_max_value_test() ->
  server:start(),
  server:addStation("aaa", {1,3}),
  server:addValue("aaa", {{2000, 10, 10},{10, 10, 10}}, "PM-10", 100),
  server:addValue("aaa", {{2000, 10, 10},{9, 12, 10}}, "PM-10", 30),
  server:addValue("aaa", {{2000, 11, 10},{9, 12, 10}}, "PM-10", 230),
  {230, ok} = {server:getMeasureMaxValue("aaa", "PM-10"), server:stop()}.
