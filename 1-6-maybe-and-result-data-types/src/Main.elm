module Main exposing (..)

import Html exposing (Html, text)
import Maybe


type Difficulty
    = Any
    | Easy
    | Medium
    | Hard


default : Difficulty
default =
    Any


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


list : List ( String, Difficulty )
list =
    [ "Any" => Any
    , "Easy" => Easy
    , "Medium" => Medium
    , "Hard" => Hard
    ]


type alias Question =
    { userAnswer : Maybe String
    , question : String
    , correct : String
    , incorrect : List String
    }


type alias Model =
    { difficulty : Difficulty
    , questions : List Question
    }


init : Model
init =
    Model
        Any
        [ Question
            (Just "To get to the other side")
            "Why did the chicken cross the road?"
            "To get to the other side"
            []
        ]


unwrapMaybe : Maybe String -> String
unwrapMaybe mb =
    Maybe.withDefault "There's no answer" mb


parsedInt : Result String Int
parsedInt =
    String.toInt "5"


unwrapResult : Result String Int -> Int
unwrapResult res =
    case res of
        Ok val ->
            val

        Err err ->
            5


view : Model -> Html msg
view { questions } =
    questions
        |> List.map
            (\{ question, userAnswer } ->
                "Question: "
                    ++ question
                    ++ " Answer: "
                    ++ (userAnswer
                            |> Maybe.map String.toUpper
                            |> Maybe.map String.reverse
                            |> unwrapMaybe
                       )
            )
        |> String.join ", "
        |> text


main : Html msg
main =
    -- view init
    parsedInt
        |> Result.toMaybe
        |> Maybe.map toString
        |> unwrapMaybe
        |> text
