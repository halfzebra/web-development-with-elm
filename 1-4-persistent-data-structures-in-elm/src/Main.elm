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
    [ { question = "Why did the chicken cross the road?"
      , correct = "To get to the other side"
      , incorrect = [ "No idea!" ]
      }
    ]


view { question, correct, incorrect } =
    "Question: "
        ++ question
        ++ " Answer: "
        ++ correct


main =
    --    params
    --        |> queryString
    --        |> text
    init
        |> List.map view
        |> String.join " "
        |> text
