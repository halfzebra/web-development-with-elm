module Main exposing (..)

import Html exposing (text)


question =
    "Why did the chicken cross the road?"


answer =
    "To get to the other side"


view model =
    text model


init =
    "Question: "
        ++ question
        ++ " Answer: "
        ++ answer


sum a b =
    a + b


sumWithOne b =
    sum 1


toUpperLambda =
    (\str -> String.toUpper str)


main =
    -- view init
    text (toString (sumWithOne 1))
