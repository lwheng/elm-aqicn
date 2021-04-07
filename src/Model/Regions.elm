module Model.Regions exposing (..)


type Region
    = North
    | South
    | East
    | West
    | Central


fromInt : Int -> Result String Region
fromInt i =
    case i of
        1 ->
            Ok North

        2 ->
            Ok South

        3 ->
            Ok East

        4 ->
            Ok West

        5 ->
            Ok Central

        _ ->
            Err "Unrecognized Int for Region"


toInt : Region -> Int
toInt region =
    case region of
        North ->
            1

        South ->
            2

        East ->
            3

        West ->
            4

        Central ->
            5


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
