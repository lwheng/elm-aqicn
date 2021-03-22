module Model.AQI exposing (..)

import Json.Decode as Json


type alias AQI =
    { name : String
    , url : String
    , pm10 : Int
    , pm25 : Int
    , iso : String
    , t : Int
    , h : Int
    }


aqiDecoder : Json.Decoder AQI
aqiDecoder =
    Json.map7 AQI
        (Json.at [ "data", "city", "name" ] Json.string)
        (Json.at [ "data", "city", "url" ] Json.string)
        (Json.at [ "data", "iaqi", "pm10", "v" ] Json.int)
        (Json.at [ "data", "iaqi", "pm25", "v" ] Json.int)
        (Json.at [ "data", "time", "iso" ] Json.string)
        (Json.at [ "data", "iaqi", "t", "v" ] Json.int)
        (Json.at [ "data", "iaqi", "h", "v" ] Json.int)
