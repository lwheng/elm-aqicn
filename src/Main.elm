module Main exposing (..)

import Browser
import Browser.Navigation as BN
import Element as E
import Element.Input as EI
import Html exposing (Html)
import Http as Http
import Json.Decode as Json
import Url exposing (Url)


main =
    Browser.application { init = init, view = view, update = update, subscriptions = subscriptions, onUrlRequest = onUrlRequest, onUrlChange = onUrlChange }


type Model
    = Failure String
    | Loading
    | Success AirQuality


type alias AirQuality =
    { name : String
    , url : String
    , pm10 : Int
    , pm25 : Int
    , iso : String
    }


defaultAirQuality : AirQuality
defaultAirQuality =
    { name = "Demo City"
    , url = "http://www.example.org"
    , pm10 = 10
    , pm25 = 25
    , iso = "2021-01-01T00:00:00+08:00"
    }


type Msg
    = Refresh
    | ReceivedData (Result Http.Error AirQuality)


init : Int -> Url -> BN.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( Loading, fetchAQIData )


view : Model -> Browser.Document Msg
view model =
    { title = "lwheng.github.io"
    , body =
        [ E.layout [] <|
            case model of
                Failure msg ->
                    E.text msg

                Loading ->
                    E.text "Loading"

                Success s ->
                    E.column []
                        [ E.text <| "Name: " ++ s.name
                        , E.text <| "Url: " ++ s.url
                        , E.text <| "PM10: " ++ String.fromInt s.pm10
                        , E.text <| "PM25: " ++ String.fromInt s.pm25
                        , E.text <| "Correct as at: " ++ s.iso
                        ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Refresh ->
            ( Loading, Cmd.none )

        ReceivedData response ->
            case response of
                Ok val ->
                    ( Success val, Cmd.none )

                Err e ->
                    case e of
                        Http.BadUrl err ->
                            ( Failure err, Cmd.none )

                        Http.Timeout ->
                            ( Failure "Timeout!", Cmd.none )

                        Http.NetworkError ->
                            ( Failure "NetworkError", Cmd.none )

                        Http.BadStatus statusCode ->
                            ( Failure <| String.fromInt statusCode, Cmd.none )

                        Http.BadBody err ->
                            ( Failure err, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ =
    Refresh


onUrlChange : Url -> Msg
onUrlChange _ =
    Refresh


fetchAQIData : Cmd Msg
fetchAQIData =
    Http.get
        { url = "https://api.waqi.info/feed/geo:1.369738;103.849338/?token=49441845ec0f10680db9bafd791d935630d6bb28"
        , expect = Http.expectJson ReceivedData airQualityDecoder
        }


airQualityDecoder : Json.Decoder AirQuality
airQualityDecoder =
    Json.map5 AirQuality
        (Json.at [ "data", "city", "name" ] Json.string)
        (Json.at [ "data", "city", "url" ] Json.string)
        (Json.at [ "data", "iaqi", "pm10", "v" ] Json.int)
        (Json.at [ "data", "iaqi", "pm25", "v" ] Json.int)
        (Json.at [ "data", "time", "iso" ] Json.string)
