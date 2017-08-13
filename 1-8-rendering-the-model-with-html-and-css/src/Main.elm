module Main exposing (..)

import Html exposing (text)
import Data.Question exposing (Question)
import View.Question


question : Question
question =
    { question = "Why did the chicken cross the road?"
    , correct = "To get to the other side"
    , incorrect = [ "I don't know" ]
    }


main =
    View.Question.view question
