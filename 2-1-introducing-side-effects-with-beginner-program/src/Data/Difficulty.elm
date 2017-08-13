module Data.Difficulty exposing (Difficulty, default)

import Util exposing ((=>))


type Difficulty
    = Any
    | Easy
    | Medium
    | Hard


list : List ( String, Difficulty )
list =
    [ "Any" => Any
    , "Easy" => Easy
    , "Medium" => Medium
    , "Hard" => Hard
    ]


default : Difficulty
default =
    Any
