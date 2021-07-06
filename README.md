# Erlang Pollution Server
Simple project wirtten in Erlang. It contains two modules:
* pollution
* server
### Module pollution:
It contains functionalities useful while storing data from weather stations.
### Module server:
It contains pollution server functionality.

-----

Available functions:
# 1. addStation
```
addStation(Name, Coordinates)
```
Function is adding station with *Name* and *Coordinates*.
* *Name* must be distinctive
* *Coordinates* must be disctinctive

# 2. addValue
```
addValue(StationIdentifier, MeasurementDate, MeasurementType, MeasurementValue)
```
Function is adding Measurement build by *MeasurementDate*, *MeasurementType* and *MeasurementValue*.
*StationIdentifier* is a *Name* or a *Coordinate* of a station.

# 3. removeValue
```
removeValue(StationIdentifier, MeasurementDate, MeasurementType)
```
Deletes Measurement from station with *StationIdentifier* with *MeasurementDate* and *MeasurementType*.

# 4. getOneValue
```
getOneValue(StationIdentifier, MeasurementDate, MeasurementType)
```
Gets a value of the Measurement that has *MeasurementDate* and *MeasurementType* from station with *StationIdentifier*.

# 5. getStationMean
```
getStationMean(StationIdentifier, MeasurementType)
```
Gets mean value of the Measurements that has *MeasurementType* from station with *StationIdentifier*.

# 6. getDailyMean
```
getDailyMean(Date, Type)
```
Gets mean value of the Measurements that has *Date* and *Type*

# 7. getHourlyMean
```
getHourlyMean(StationIdentifier, Hour, Type)
```
Gets mean value of the Measurements that has *Hour* and *Type* from *StationIdentifier*

# 8. getLastMeasurement
```
getLastMeasurement(StationIdentifier, Type)
```
Gets last value of the Measurements that has *Type* from *StationIdentifier*

# 9. getMeasureMaxValue
```
getMeasureMaxValue(StationIdentifier, Type)
```
Gets biggest value of the Measurements that has *Type* from *StationIdentifier*
