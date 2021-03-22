module View.AQICard exposing (..)

import Element as E
import Element.Background as Background
import Model.AQI exposing (..)
import Model.AirQualityLevel as AirQualityLevel
import Update.Msg exposing (..)


aqiCard : AQI -> E.Element Msg
aqiCard aqi =
    let
        airQualityLevel =
            AirQualityLevel.pm25ToAirQualityLevel aqi.pm25
    in
    E.row [ Background.color <| AirQualityLevel.color airQualityLevel, E.width E.fill ]
        [ E.column [ Background.color <| AirQualityLevel.color airQualityLevel, E.width E.fill ]
            [ E.text <| "PM25: " ++ String.fromInt aqi.pm25
            , E.text <| "Air Pollution Level: " ++ AirQualityLevel.toString airQualityLevel
            ]
        , E.column [ Background.color <| AirQualityLevel.color airQualityLevel, E.width E.fill ]
            [ E.text <| "Name: " ++ aqi.name
            , E.text <| "Url: " ++ aqi.url
            , E.text <| "PM10: " ++ String.fromInt aqi.pm10
            , E.text <| "Temperature (°C): " ++ String.fromInt aqi.t
            , E.text <| "Humidity: " ++ String.fromInt aqi.h
            , E.text <| "Correct as at: " ++ aqi.iso
            ]
        ]
