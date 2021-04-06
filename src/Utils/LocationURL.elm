module Utils.LocationURL exposing (..)

import Model.Locations as L
import Model.Regions as R
import String as S
import Url as Url
import Url.Builder as UrlBuilder


token : String
token =
    "49441845ec0f10680db9bafd791d935630d6bb28"


mkLocationURL : L.Location -> Url.Url
mkLocationURL loc =
    { protocol = Url.Https
    , host = "api.waqi.info"
    , port_ = Nothing
    , path = mkPath loc
    , query = Nothing
    , fragment = Nothing
    }


mkPath : L.Location -> String
mkPath loc =
    UrlBuilder.absolute [ "feed", mkGeo loc.lat loc.long, "" ] [ UrlBuilder.string "token" token ]


mkGeo : Float -> Float -> String
mkGeo lat long =
    "geo:" ++ S.fromFloat lat ++ ";" ++ S.fromFloat long
