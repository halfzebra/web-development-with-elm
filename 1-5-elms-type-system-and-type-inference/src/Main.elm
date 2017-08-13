module Main exposing (..)

import Html exposing (Html, text)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


type Difficulty
    = Any
    | Easy
    | Medium
    | Hard


default : Difficulty
default =
    Medium


list : List ( String, Difficulty )
list =
    [ "Any" => Any
    , "Easy" => Easy
    , "Medium" => Medium
    , "Hard" => Hard
    ]


type alias Question =
    { question : String
    , correct : String
    , incorrect : List String
    }


type alias Model =
    { difficulty : Difficulty
    , questions : List Question
    }


questions : List Question
questions =
    [ Question
        "&quot;Why did the chicken cross the road?&quot;"
        "To get to the other side"
        [ "I don't know!" ]
    , { question = "&quot;Why did the chicken cross the Möbius strip?&quot;"
      , correct = "To get to the same side."
      , incorrect = [ "To get to the other side" ]
      }
    ]


replace : String -> String -> String -> String
replace needle replaceWith haystack =
    String.join replaceWith (String.split needle haystack)


htmlEntities : List ( String, String )
htmlEntities =
    [ "&#039;" => "'"
    , "&rsquo;" => "'"
    , "&quot;" => "\""
    , "&eacute;" => "é"
    ]


replaceHtmlEntities : String -> String
replaceHtmlEntities str =
    List.foldl (uncurry replace) str htmlEntities


init : Model
init =
    Model default questions


view : Model -> Html msg
view { questions } =
    questions
        |> List.map
            (\{ question, correct } ->
                "Question: "
                    ++ (replaceHtmlEntities question)
                    ++ " Answer: "
                    ++ (replaceHtmlEntities correct)
            )
        |> String.join " "
        |> text


main : Html msg
main =
    view init
