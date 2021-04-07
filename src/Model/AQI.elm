module Model.AQI exposing (..)

import Json.Decode as Json


type alias AQI =
    { name : String
    , url : String
    , pm10 : Float
    , pm25 : Float
    , iso : String
    , t : Float
    , h : Float
    }


aqiDecoder : Json.Decoder AQI
aqiDecoder =
    Json.map7 AQI
        (Json.at [ "data", "city", "name" ] Json.string)
        (Json.at [ "data", "city", "url" ] Json.string)
        (Json.at [ "data", "iaqi", "pm10", "v" ] Json.float)
        (Json.at [ "data", "iaqi", "pm25", "v" ] Json.float)
        (Json.at [ "data", "time", "iso" ] Json.string)
        (Json.at [ "data", "iaqi", "t", "v" ] Json.float)
        (Json.at [ "data", "iaqi", "h", "v" ] Json.float)
