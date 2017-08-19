module Main exposing (..)

import Html exposing (Html, text)
import Util exposing ((=>))
import Data.Difficulty exposing (Difficulty, default)
import Data.Question exposing (Question)
import View.Question


type alias Model =
    { difficulty : Difficulty
    , questions : List Question
    }


init : Model
init =
    Model
        default
        [ Question
            (Just "To get to the other side")
            "Why did the chicken cross the road?"
            "To get to the other side"
            []
        ]


main : Html msg
main =
    init.questions
        |> List.map View.Question.view
        |> String.join ", "
        |> text
