module Main exposing (..)

import Browser
import Browser.Navigation as BN
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Url exposing (Url)


main =
    Browser.application { init = init, view = view, update = update, subscriptions = subscriptions, onUrlRequest = onUrlRequest, onUrlChange = onUrlChange }


type alias Model =
    Int


type Msg
    = Increment
    | Decrement


init : Int -> Url -> BN.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( 0, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Hello World"
    , body =
        [ div []
            [ button [ onClick Decrement ] [ text "-" ]
            , div [] [ text (String.fromInt model) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ =
    Increment


onUrlChange : Url -> Msg
onUrlChange _ =
    Increment
