module Model.AirQualityPM10Level exposing (..)

import Element as E


textColor : Int -> E.Color
textColor level =
    case level of
        1 ->
            E.rgb255 255 255 255

        2 ->
            E.rgb255 255 255 255

        3 ->
            E.rgb255 0 0 0

        4 ->
            E.rgb255 0 0 0

        5 ->
            E.rgb255 0 0 0

        6 ->
            E.rgb255 0 0 0

        7 ->
            E.rgb255 0 0 0

        8 ->
            E.rgb255 0 0 0

        9 ->
            E.rgb255 255 255 255

        10 ->
            E.rgb255 255 255 255

        11 ->
            E.rgb255 255 255 255

        _ ->
            E.rgb255 255 255 255


color : Int -> E.Color
color level =
    case level of
        1 ->
            E.rgb255 0 109 114

        2 ->
            E.rgb255 0 143 92

        3 ->
            E.rgb255 116 180 74

        4 ->
            E.rgb255 255 216 66

        5 ->
            E.rgb255 255 177 62

        6 ->
            E.rgb255 255 139 58

        7 ->
            E.rgb255 234 64 51

        8 ->
            E.rgb255 205 2 50

        9 ->
            E.rgb255 147 3 92

        10 ->
            E.rgb255 114 1 55

        11 ->
            E.rgb255 72 0 22

        _ ->
            E.rgb255 0 0 0


pm10ToLevel : Float -> Int
pm10ToLevel pm10 =
    if 0 <= pm10 && pm10 < 25 then
        1

    else if 25 <= pm10 && pm10 < 50 then
        2

    else if 50 <= pm10 && pm10 < 75 then
        3

    else if 75 <= pm10 && pm10 < 100 then
        4

    else if 100 <= pm10 && pm10 < 125 then
        5

    else if 125 <= pm10 && pm10 < 150 then
        6

    else if 150 <= pm10 && pm10 < 175 then
        7

    else if 175 <= pm10 && pm10 < 200 then
        8

    else if 200 <= pm10 && pm10 < 300 then
        9

    else if 300 <= pm10 && pm10 < 400 then
        10

    else if 400 <= pm10 && pm10 < 500 then
        11

    else
        12
