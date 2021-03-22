module Model.AQI exposing (..)


type alias AQI =
    { name : String
    , url : String
    , pm10 : Int
    , pm25 : Int
    , iso : String
    , t : Int
    , h : Int
    }
