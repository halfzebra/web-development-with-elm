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


type alias Question =
    { question : String
    , correct : String
    , incorrect : List String
    }


questions : List Question
questions =
    [ Question
        "Why did the chicken cross the road?"
        "To get to the other side"
        [ "" ]
    , Question
        "Why did the chicken cross the Möbius strip?"
        "To get to the same side."
        [ "" ]
    ]


replace : String -> String -> String -> String
replace needle replaceWith haystack =
    String.join replaceWith (String.split needle haystack)


htmlEntities : List ( String, String )
htmlEntities =
    [ "&#039;" => "'"
    , "&rsquo;" => "'"
    , "&quot;" => "\""
    ]


replaceHtmlEntities : String -> String
replaceHtmlEntities str =
    List.foldl (uncurry replace) str htmlEntities


stringWithHtmlSpecialCharacters : String
stringWithHtmlSpecialCharacters =
    "A pure function has no &quot;back doors&quot;"


main : Html msg
main =
    text (replaceHtmlEntities stringWithHtmlSpecialCharacters)
