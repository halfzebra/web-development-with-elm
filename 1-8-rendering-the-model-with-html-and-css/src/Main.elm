module Main exposing (..)

import Html exposing (Html, div, input)
import Html.Attributes exposing (style, value)
import Data.Difficulty exposing (Difficulty)
import Data.Question exposing (Question)
import View.Question
import Util exposing ((=>))


type alias Model =
    { difficulty : Difficulty
    , amount : Int
    , questions : List Question
    }


init : Model
init =
    Model Data.Difficulty.default
        5
        [ Question
            Nothing
            "Why did the chicken cross the road?"
            "To get to the other side"
            [ "I don't know" ]
        ]


view { amount, questions } =
    div
        [ style
            [ "max-width" => "300px"
            , "margin" => "0 auto"
            ]
        ]
        [ input [ value (toString amount) ] []
        , div
            []
            (List.map View.Question.view questions)
        ]


main : Html msg
main =
    view init
