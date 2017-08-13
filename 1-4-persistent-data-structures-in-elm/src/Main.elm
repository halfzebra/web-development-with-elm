module Main exposing (..)

import Html exposing (text)
import Array exposing (Array)
import Dict exposing (Dict)
import Set exposing (Set)


list =
    --[ 1, 2, 3 ]
    1 :: [] ++ [ 2 ]



-- UTIL


(=>) =
    (,)


htmlEntities =
    [ "&#039;" => "'"
    , "&rsquo;" => "'"
    , "&quot;" => "\""
    , "&eacute;" => "é"
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



-- MODEL


init =
    [ { question = "&quot;Why did the chicken cross the road?&quot;"
      , correct = "&quot;To get to the other side&quot;"
      , incorrect = [ "&quot;No idea!&quot;" ]
      }
    ]


view { question, correct, incorrect } =
    "Question: "
        ++ (replaceHtmlEntities question)
        ++ " Answer: "
        ++ (replaceHtmlEntities correct)


main =
    --    params
    --        |> queryString
    --        |> text
    init
        |> List.map view
        |> String.join " "
        |> text
