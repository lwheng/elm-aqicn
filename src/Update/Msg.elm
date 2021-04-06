module Update.Msg exposing (..)

import Http as Http
import Model.AQI exposing (..)
import Model.Regions exposing (..)


type Msg
    = Refresh
    | ReceivedData (Result Http.Error AQI)
