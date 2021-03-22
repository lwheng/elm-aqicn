module View.AQICard exposing (..)

import Element as E
import Model.AQI exposing (..)
import Update.Msg exposing (..)


aqiCard : AQI -> E.Element Msg
aqiCard aqi =
    E.column []
        [ E.text <| "Name: " ++ aqi.name
        , E.text <| "Url: " ++ aqi.url
        , E.text <| "PM10: " ++ String.fromInt aqi.pm10
        , E.text <| "PM25: " ++ String.fromInt aqi.pm25
        , E.text <| "Temperate (°C): " ++ String.fromInt aqi.t
        , E.text <| "Humidity: " ++ String.fromInt aqi.h
        , E.text <| "Correct as at: " ++ aqi.iso
        ]
