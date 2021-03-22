module Model.Model exposing (..)

import Model.AQI exposing (..)


type Model
    = Failure String
    | Loading
    | Success AQI
