module View.AQICard exposing (..)

import Element as E
import Element.Background as Background
import Element.Font as Font
import Model.AQI exposing (..)
import Model.AirQualityLevel as AirQualityLevel
import Model.AirQualityPM10Level as AirQualityPM10Level
import Update.Msg exposing (..)


grey : E.Color
grey =
    E.rgb255 100 100 100


black : E.Color
black =
    E.rgb255 0 0 0


aqiCard : AQI -> E.Element Msg
aqiCard aqi =
    let
        levelPM25 =
            AirQualityLevel.pm25ToAirQualityLevel aqi.pm25

        colorPM25 =
            AirQualityLevel.color levelPM25

        textColorPM25 =
            AirQualityLevel.textColor levelPM25

        colorPM10 =
            AirQualityPM10Level.color <| AirQualityPM10Level.pm10ToLevel aqi.pm10

        textColorPM10 =
            AirQualityPM10Level.textColor <| AirQualityPM10Level.pm10ToLevel aqi.pm10
    in
    E.column
        [ E.width E.fill
        , E.height E.fill
        , E.padding 25
        ]
        [ view_aqiName black aqi.name
        , E.row
            [ E.width E.fill
            , E.height E.fill
            , E.padding 25
            ]
            [ E.column
                [ Background.color colorPM25
                , E.padding 20
                , E.width E.fill
                ]
                [ view_aqiTitle "PM 2.5" textColorPM25
                , view_aqiNum textColorPM25 aqi.pm25
                , view_aqiFooter textColorPM25 <| AirQualityLevel.toString levelPM25
                ]
            , E.column
                [ Background.color colorPM10
                , E.padding 20
                , E.width E.fill
                ]
                [ view_aqiTitle "PM 10" textColorPM10
                , view_aqiNum textColorPM10 aqi.pm10
                , view_aqiFooter black " "
                ]
            , E.column
                [ E.padding 20
                , E.width E.fill
                ]
                [ view_aqiTitle "Temp (°C)" black
                , view_aqiNum black aqi.t
                , view_aqiFooter black " "
                ]
            , E.column
                [ E.padding 20
                , E.width E.fill
                ]
                [ view_aqiTitle "Humidity" black
                , view_aqiNum black aqi.h
                , view_aqiFooter black " "
                ]
            ]
        ]


view_aqiTitle : String -> E.Color -> E.Element Msg
view_aqiTitle title textColor =
    E.el
        [ E.width E.fill
        , Font.center
        , Font.color textColor
        , Font.shadow { offset = ( 2, 2 ), blur = 3, color = grey }
        , Font.size 20
        ]
        (E.text title)


view_aqiFooter : E.Color -> String -> E.Element Msg
view_aqiFooter textColor footer =
    E.el
        [ E.width E.fill
        , Font.center
        , Font.color textColor
        , Font.shadow { offset = ( 2, 2 ), blur = 3, color = grey }
        , Font.size 32
        ]
        (E.text footer)


view_aqiNum : E.Color -> Float -> E.Element Msg
view_aqiNum textColor num =
    E.el
        [ E.centerX
        , Font.color textColor
        , Font.shadow { offset = ( 2, 2 ), blur = 3, color = grey }
        , Font.size 128
        ]
        (E.text <| String.fromFloat num)


view_aqiName : E.Color -> String -> E.Element Msg
view_aqiName textColor name =
    E.el
        [ E.centerX
        , Font.color textColor
        , Font.size 32
        ]
        (E.text name)
