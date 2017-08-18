module Main exposing (..)

import Html exposing (text)


question =
    "The board game Go has more possible legal positions than the number of atoms in the visible universe."


answer =
    True


addLabels question answer =
    "Question: " ++ question ++ " Answer: " ++ (toString answer)


view model =
    model
        |> String.toUpper
        |> text


init =
    addLabels question answer


main =
    view init
