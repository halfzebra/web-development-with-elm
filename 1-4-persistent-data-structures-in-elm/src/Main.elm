module Main exposing (..)

import Html exposing (text)
import Array exposing (Array)
import Dict exposing (Dict)
import Set exposing (Set)


(=>) =
    (,)


list =
    --[ 1, 2, 3 ]
    1 :: [] ++ [ 2 ]


htmlEntities =
    [ "&#039;" => "'"
    , "&rsquo;" => "'"
    , "&quot;" => "\""
    ]


replace needle replaceWith haystack =
    String.join replaceWith (String.split needle haystack)


replaceHtmlEntities str =
    List.foldl (uncurry replace) str htmlEntities


queryString list =
    list
        |> List.map (\( a, b ) -> a ++ "=" ++ b)
        |> String.join "&"
        |> (++) "?"


params =
    [ "difficulty" => "easy"
    , "amount" => "10"
    ]


main =
    params
        |> queryString
        |> text
