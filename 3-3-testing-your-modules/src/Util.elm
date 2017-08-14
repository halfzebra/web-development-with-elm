module Util exposing ((=>), onChange, replaceHtmlEntities, appendIf)

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Json.Decode


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)


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


appendIf : Bool -> a -> List a -> List a
appendIf flag value list =
    if flag == True then
        list ++ [ value ]
    else
        list
