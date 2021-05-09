-module(server).
-author("Janusz").

-export([start/0, addStation/2, addValue/4, removeValue/3, getOneValue/3, getStationMean/2, getDailyMean/2, getHourlyMean/3, getLastMeasurement/2, getMeasureMaxValue/2, init/0, stop/0]).

start() ->
  register(monitorServer, spawn(server, init, [])).

init() ->
  State = pollution:createMonitor(),
  loop(State).

loop(State) ->
  receive
    {getValue, Function, Pid, Data} ->
      Value = apply(pollution, Function, Data ++ [State]),
      Pid ! Value,
      loop(State);
    {modifyState, Function, Pid, Data} ->
      {Status, NewState} = apply(pollution, Function, Data ++ [State]),
      Pid ! Status,
      loop(NewState);
    {stop, Pid} ->
      terminate(Pid)
  end.

terminate(Pid) ->
  Pid ! ok.

receiveMessage() ->
  receive
    Status -> Status
  after
    1000 ->
      timeout
  end.

addStation(Name, Coordinates) ->
  monitorServer ! {modifyState, addStation, self(), [Name, Coordinates]},
  receiveMessage().

addValue(StationIdentifier, MeasurementDate, MeasurementType, MeasurementValue) ->
  monitorServer ! {modifyState, addValue, self(), [StationIdentifier, MeasurementDate, MeasurementType, MeasurementValue]},
  receiveMessage().

removeValue(StationIdentifier, MeasurementDate, MeasurementType) ->
  monitorServer ! {modifyState, removeValue, self(), [StationIdentifier, MeasurementDate, MeasurementType]},
  receiveMessage().

getOneValue(StationIdentifier, MeasurementDate, MeasurementType) ->
  monitorServer ! {getValue, getOneValue, self(), [StationIdentifier, MeasurementDate, MeasurementType]},
  receiveMessage().

getStationMean(StationIdentifier, MeasurementType) ->
  monitorServer ! {getValue, getStationMean, self(), [StationIdentifier, MeasurementType]},
  receiveMessage().

getDailyMean(Date, Type) ->
  monitorServer ! {getValue, getDailyMean, self(), [Date, Type]},
  receiveMessage().

getHourlyMean(StationIdentifier, Hour, Type) ->
  monitorServer ! {getValue, getHourlyMean, self(), [StationIdentifier, Hour, Type]},
  receiveMessage().

getLastMeasurement(StationIdentifier, Type) ->
  monitorServer ! {getValue, getLastMeasurment, self(), [StationIdentifier, Type]},
  receiveMessage().

getMeasureMaxValue(StationIdentifier, Type) ->
  monitorServer ! {getValue, getMeasureMaxValue, self(), [StationIdentifier, Type]},
  receiveMessage().

stop() ->
  monitorServer ! {stop, self()},
  receiveMessage().
