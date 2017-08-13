module Main exposing (..)

import Html exposing (text)
import Data.Difficulty exposing (Difficulty)
import Data.Question exposing (Question)
import View.Question


type alias Model =
    { difficulty : Difficulty
    , questions : List Question
    }


init =
    Model Data.Difficulty.default
        [ Question
            "Why did the chicken cross the road?"
            "To get to the other side"
            [ "I don't know" ]
        ]


main =
    init
        |> .questions
        |> List.map View.Question.view
        |> String.join " "
        |> text
