module Main exposing (..)

import Browser
import Browser.Navigation as BN
import Dict as Dict
import Element as E
import Element.Input as EI
import Html exposing (Html)
import Http as Http
import List exposing (..)
import Model.AQI as AQI
import Model.Locations as L
import Model.Model exposing (..)
import Model.Regions as R
import Update.Msg exposing (..)
import Url exposing (Url)
import Utils.LocationURL as LURL
import View.AQICard exposing (..)


main =
    Browser.application { init = init, view = view, update = update, subscriptions = subscriptions, onUrlRequest = onUrlRequest, onUrlChange = onUrlChange }


init : Int -> Url -> BN.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( initModel, fetchAllLocation )


view : Model -> Browser.Document Msg
view model =
    { title = "lwheng.github.io"
    , body =
        [ E.layout [] <|
            if Dict.isEmpty model.aqis then
                E.text "Nothing to display"

            else
                E.column [ E.width E.fill, E.height E.fill ] <| map aqiCard <| Dict.values model.aqis
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Refresh ->
            ( initModel, fetchAllLocation )

        ReceivedData region response ->
            case response of
                Ok val ->
                    ( { model | aqis = Dict.insert (R.toInt region) val model.aqis }, Cmd.none )

                Err e ->
                    case e of
                        Http.BadUrl err ->
                            ( { initModel | status = "Bad Url: " ++ err }, Cmd.none )

                        Http.Timeout ->
                            ( { initModel | status = "Request timeout!" }, Cmd.none )

                        Http.NetworkError ->
                            ( { initModel | status = "Network Error" }, Cmd.none )

                        Http.BadStatus statusCode ->
                            ( { initModel | status = "Bad Status Code: " ++ String.fromInt statusCode }, Cmd.none )

                        Http.BadBody err ->
                            ( { initModel | status = err }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ =
    Refresh


onUrlChange : Url -> Msg
onUrlChange _ =
    Refresh


fetchAllLocation : Cmd Msg
fetchAllLocation =
    Cmd.batch <| map fetchOneLocation L.locations


fetchOneLocation : L.Location -> Cmd Msg
fetchOneLocation loc =
    Http.get
        { url = Url.toString <| LURL.mkLocationURL loc
        , expect = Http.expectJson (ReceivedData loc.region) AQI.aqiDecoder
        }
