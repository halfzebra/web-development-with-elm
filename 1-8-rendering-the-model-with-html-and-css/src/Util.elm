module Util exposing ((=>))

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Json.Decode


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
