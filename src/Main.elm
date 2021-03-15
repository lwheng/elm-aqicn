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
    = Failure
    | Loading
    | Success String


type Msg
    = Refresh
    | ReceivedData (Result Http.Error String)


init : Int -> Url -> BN.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( Loading, fetchAQIData )


view : Model -> Browser.Document Msg
view model =
    { title = "lwheng.github.io"
    , body =
        [ E.layout [] <|
            E.column []
                [ E.text <|
                    case model of
                        Failure ->
                            "Failure"

                        Loading ->
                            "Loading"

                        Success s ->
                            s
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
                Ok json ->
                    ( Success json, Cmd.none )

                Err e ->
                    case e of
                        Http.BadUrl err ->
                            ( Success err, Cmd.none )

                        Http.Timeout ->
                            ( Success "Timeout!", Cmd.none )

                        Http.NetworkError ->
                            ( Success "NetworkError", Cmd.none )

                        Http.BadStatus statusCode ->
                            ( Success <| String.fromInt statusCode, Cmd.none )

                        Http.BadBody err ->
                            ( Success err, Cmd.none )


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


aqiDecoder : Json.Decoder String
aqiDecoder =
    Json.field "data" (Json.field "city" (Json.field "name" Json.string))
