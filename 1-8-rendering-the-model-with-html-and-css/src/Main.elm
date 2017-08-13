module Main exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Data.Difficulty exposing (Difficulty)
import Data.Question exposing (Question)
import View.Question
import Util exposing ((=>))


type alias Model =
    { difficulty : Difficulty
    , questions : List Question
    }


init : Model
init =
    Model Data.Difficulty.default
        [ Question
            "Why did the chicken cross the road?"
            "To get to the other side"
            [ "I don't know" ]
        ]


main : Html msg
main =
    div
        [ style [ "text-align" => "center" ] ]
        (List.map View.Question.view init.questions)
