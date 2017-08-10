module Main exposing (..)

import Html exposing (text)


{-
   main =
       text "Hello"
-}
{-
   message =
       "Hello from Elm!"


   main =
       text (message)
-}
{-
   message from =
       "Hello from " ++ from


   main =
       text (message "Elm")
-}

{-

message greeting from =
    greeting ++ " from " ++ from


helloFrom x =
    message "Hello"


main =
    text (helloFrom "Elm")

-}


{-

   message =
       "Hello from Elm!"


   replace needle replaceWith haystack =
       String.join replaceWith (String.split needle haystack)


   main =
       text (replace "Hello" "Hola" message)

-}
