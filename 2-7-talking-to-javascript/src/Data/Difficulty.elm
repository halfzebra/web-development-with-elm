module Data.Difficulty
    exposing
        ( Difficulty
        , keys
        , default
        , get
        , isAny
        , toString
        )

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


keys : List String
keys =
    list
        -- (List String, List Difficulty)
        |> List.unzip
        |> Tuple.first


get : String -> Difficulty
get key =
    list
        |> List.filter (\( k, v ) -> k == key)
        -- Maybe ( String, Difficulty )
        |> List.head
        |> Maybe.map Tuple.second
        |> Maybe.withDefault default


isAny : Difficulty -> Bool
isAny lvl =
    Any == lvl


toString : Difficulty -> String
toString lvl =
    list
        |> List.filter (\( _, v ) -> v == lvl)
        -- Maybe ( String, Difficulty )
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault "Any"
