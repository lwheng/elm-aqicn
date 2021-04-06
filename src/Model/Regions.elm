module Model.Regions exposing (..)


type Region
    = North
    | South
    | East
    | West
    | Central


regionToString : Region -> String
regionToString region =
    case region of
        North ->
            "North"

        South ->
            "South"

        East ->
            "East"

        West ->
            "West"

        Central ->
            "Central"
