module View.AQICard exposing (..)

import Element as E
import Element.Background as Background
import Element.Font as Font
import Model.AQI exposing (..)
import Model.AirQualityLevel as AirQualityLevel
import Update.Msg exposing (..)


aqiCard : AQI -> E.Element Msg
aqiCard aqi =
    let
        airQualityLevel =
            AirQualityLevel.pm25ToAirQualityLevel aqi.pm25

        airQualityColor =
            AirQualityLevel.color airQualityLevel

        airQualityTextColor =
            AirQualityLevel.textColor airQualityLevel
    in
    E.row
        [ Background.color <| AirQualityLevel.color airQualityLevel
        , E.width E.fill
        , E.height E.fill
        , E.padding 10
        ]
        [ E.column
            [ Background.color <| AirQualityLevel.color airQualityLevel
            , E.padding 20
            ]
            [ view_aqiPM25 airQualityTextColor aqi.pm25
            , view_aqiAirQualityLevel airQualityTextColor airQualityLevel
            ]
        , E.column
            [ Background.color airQualityColor
            , E.padding 10
            , E.width E.fill
            ]
            [ E.text <| "Name: " ++ aqi.name
            , E.text <| "Url: " ++ aqi.url
            , E.text <| "PM10: " ++ String.fromFloat aqi.pm10
            , E.text <| "Temperature (°C): " ++ String.fromFloat aqi.t
            , E.text <| "Humidity: " ++ String.fromFloat aqi.h
            , E.text <| "Correct as at: " ++ aqi.iso
            ]
        ]


view_aqiAirQualityLevel : E.Color -> AirQualityLevel.AirQualityLevel -> E.Element Msg
view_aqiAirQualityLevel textColor airQualityLevel =
    E.el
        [ E.width E.fill
        , Font.center
        , Font.color textColor
        , Font.shadow { offset = ( 2, 2 ), blur = 3, color = E.rgb255 0 0 0 }
        , Font.size 32
        ]
        (E.text <| AirQualityLevel.toString airQualityLevel)


view_aqiPM25 : E.Color -> Float -> E.Element Msg
view_aqiPM25 textColor pm25 =
    E.el
        [ E.centerX
        , Font.color textColor
        , Font.shadow { offset = ( 2, 2 ), blur = 3, color = E.rgb255 0 0 0 }
        , Font.size 128
        ]
        (E.text <| String.fromFloat pm25)
