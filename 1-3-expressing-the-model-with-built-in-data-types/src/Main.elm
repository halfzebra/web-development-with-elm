module Main exposing (..)

import Html exposing (text)


{-

   question =
       "Why did the chicken cross the road?"


   answer =
       "To get to the other side"


   init =
       ( question, answer )


   view (question, answer) =
       text
           ("Question: "
               ++ (Tuple.first model)
               ++ " Answer: "
               ++ (Tuple.second model)
           )

-}


init =
    { question = "Why did the chicken cross the road?"
    , answer = "To get to the other side"
    }


view model =
    text
        ("Question: "
            ++ (.question model)
            ++ " Answer: "
            ++ (.answer model)
        )


main =
    view init
