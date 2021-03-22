module Model.AirQualityLevel exposing (..)


type AirQualityLevel
    = Good
    | Moderate
    | UnhealthySensitiveGroup
    | Unhealthy
    | VeryUnhealthy
    | Hazardous


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
