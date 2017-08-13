module Util exposing ((=>), replaceHtmlEntities)

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Json.Decode


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


replace : String -> String -> String -> String
replace needle replaceWith haystack =
    String.join replaceWith (String.split needle haystack)


htmlEntities : List ( String, String )
htmlEntities =
    [ "&#039;" => "'"
    , "&rsquo;" => "'"
    , "&quot;" => "\""
    , "&eacute;" => "é"
    ]


replaceHtmlEntities : String -> String
replaceHtmlEntities str =
    List.foldl (uncurry replace) str htmlEntities
