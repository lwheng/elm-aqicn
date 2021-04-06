module Model.Locations exposing (..)

import Model.Regions as R


type alias Location =
    { region : R.Region
    , lat : Float
    , long : Float
    }


locations : List Location
locations =
    [ { region = R.North, lat = 1.42962, long = 103.795915 }
    , { region = R.South, lat = 1.311999, long = 103.796138 }
    , { region = R.East, lat = 1.364773, long = 103.948014 }
    , { region = R.West, lat = 1.387733, long = 103.69829 }
    , { region = R.Central, lat = 1.367261, long = 103.79982 }
    ]
