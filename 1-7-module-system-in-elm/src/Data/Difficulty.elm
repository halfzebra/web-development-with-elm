module Data.Difficulty exposing (Difficulty, default)

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
