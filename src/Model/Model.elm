module Model.Model exposing (..)

import Dict as Dict
import Model.AQI exposing (..)
import Model.Regions exposing (..)


type alias Model =
    { aqis : Dict.Dict Int AQI -- Int is derived from Model.Regions
    , status : String
    }


initModel : Model
initModel =
    { aqis = Dict.empty, status = "Nothing to display" }
