module Data.Difficulty exposing (Difficulty, toString, get, keys, isAny, default)

import Util exposing ((=>))


type Difficulty
    = Any
    | Easy
    | Medium
    | Hard


default : Difficulty
default =
    Any


list : List ( String, Difficulty )
list =
    [ "Any" => Any
    , "Easy" => Easy
    , "Medium" => Medium
    , "Hard" => Hard
    ]


get : String -> Difficulty
get name =
    list
        |> List.filter (\( k, v ) -> k == name)
        |> List.head
        |> Maybe.map Tuple.second
        |> Maybe.withDefault Any


keys : List String
keys =
    list
        |> List.unzip
        |> Tuple.first


toString : Difficulty -> String
toString tag =
    list
        |> List.filter (\( k, v ) -> v == tag)
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault "Any"


isAny : Difficulty -> Bool
isAny difficulty =
    difficulty == Any
