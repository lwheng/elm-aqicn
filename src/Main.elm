module Main exposing (..)

import Browser
import Browser.Navigation as BN
import Element as E
import Element.Input as EI
import Html exposing (Html)
import Http as Http
import Json.Decode as Json
import Model.AQI exposing (..)
import Model.Model exposing (..)
import Update.Msg exposing (..)
import Url exposing (Url)
import View.AQICard exposing (..)


main =
    Browser.application { init = init, view = view, update = update, subscriptions = subscriptions, onUrlRequest = onUrlRequest, onUrlChange = onUrlChange }


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
                    aqiCard s
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
        , expect = Http.expectJson ReceivedData aqiDecoder
        }


aqiDecoder : Json.Decoder AQI
aqiDecoder =
    Json.map7 AQI
        (Json.at [ "data", "city", "name" ] Json.string)
        (Json.at [ "data", "city", "url" ] Json.string)
        (Json.at [ "data", "iaqi", "pm10", "v" ] Json.int)
        (Json.at [ "data", "iaqi", "pm25", "v" ] Json.int)
        (Json.at [ "data", "time", "iso" ] Json.string)
        (Json.at [ "data", "iaqi", "t", "v" ] Json.int)
        (Json.at [ "data", "iaqi", "h", "v" ] Json.int)
