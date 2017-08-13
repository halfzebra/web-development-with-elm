module Main exposing (..)

import Html exposing (text)


message =
    "Hello from Elm!"


messageFrom from =
    "Hello from " ++ from


messageWithGreetingFrom greeting from =
    greeting ++ " from " ++ from


helloFrom =
    messageWithGreetingFrom "Hello"


replace needle replaceWith haystack =
    String.join replaceWith (String.split needle haystack)



{- Alternative implemenation using pipes:

   replace needle replaceWith haystack =
       haystack
           |> String.split needle
           |> String.join replaceWith
-}


increment x =
    x + 1


lambdaIncrement =
    (\x -> x + 1)


main =
    -- text "Hello"
    -- text (message)
    -- text (messageFrom "Elm")
    -- text (helloFrom "Elm")
    -- text (replace "Hello" "Hola" message)
    message
        |> replace "Hello" "Hola"
        |> text
