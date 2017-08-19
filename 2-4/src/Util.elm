module Util exposing ((=>), onChange)

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Json.Decode


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)
