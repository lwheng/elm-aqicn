module Model.Model exposing (..)

import Model.AQI exposing (..)


type alias Model =
    { aqis : List AQI
    , status : String
    }


initModel : Model
initModel =
    { aqis = [], status = "Nothing to display" }
