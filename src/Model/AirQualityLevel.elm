module Model.AirQualityLevel exposing (..)

import Element as E


type AirQualityLevel
    = Good
    | Moderate
    | UnhealthySensitiveGroup
    | Unhealthy
    | VeryUnhealthy
    | Hazardous


toString : AirQualityLevel -> String
toString level =
    case level of
        Good ->
            "Good"

        Moderate ->
            "Moderate"

        UnhealthySensitiveGroup ->
            "Unhealthy for\nSensitive Groups"

        Unhealthy ->
            "Unhealthy"

        VeryUnhealthy ->
            "Very\nUnhealthy"

        Hazardous ->
            "Hazardous"


textColor : AirQualityLevel -> E.Color
textColor level =
    case level of
        Good ->
            E.rgb255 255 255 255

        Moderate ->
            E.rgb255 0 0 0

        UnhealthySensitiveGroup ->
            E.rgb255 0 0 0

        Unhealthy ->
            E.rgb255 255 255 255

        VeryUnhealthy ->
            E.rgb255 255 255 255

        Hazardous ->
            E.rgb255 255 255 255


color : AirQualityLevel -> E.Color
color level =
    case level of
        Good ->
            E.rgb255 0 142 93

        Moderate ->
            E.rgb255 255 217 66

        UnhealthySensitiveGroup ->
            E.rgb255 255 142 58

        Unhealthy ->
            E.rgb255 207 2 48

        VeryUnhealthy ->
            E.rgb255 94 4 139

        Hazardous ->
            E.rgb255 120 1 33


pm25ToAirQualityLevel : Int -> AirQualityLevel
pm25ToAirQualityLevel pm25 =
    if 0 <= pm25 && pm25 <= 50 then
        Good

    else if 51 <= pm25 && pm25 <= 100 then
        Moderate

    else if 101 <= pm25 && pm25 <= 150 then
        UnhealthySensitiveGroup

    else if 151 <= pm25 && pm25 <= 200 then
        Unhealthy

    else if 201 <= pm25 && pm25 <= 300 then
        VeryUnhealthy

    else
        Hazardous
