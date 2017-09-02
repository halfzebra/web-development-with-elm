module Data.TriviaZipList
    exposing
        ( TriviaZipList
        , fromList
        , answer
        , next
        , current
        )

import Data.Question exposing (Question)


type TriviaZipList
    = TriviaZipList
        { previous : List Question
        , current : Question
        , rest : List Question
        }


fromList : List Question -> TriviaZipList
fromList list =
    case list of
        [ x ] ->
            TriviaZipList
                { previous = []
                , current = x
                , rest = []
                }

        x :: rest ->
            TriviaZipList
                { previous = []
                , current = x
                , rest = rest
                }

        _ ->
            Debug.crash "Impossible state!"


next : TriviaZipList -> TriviaZipList
next (TriviaZipList { previous, current, rest }) =
    case rest of
        [] ->
            TriviaZipList
                { previous = previous
                , current = current
                , rest = []
                }

        x :: rest ->
            TriviaZipList
                { previous = previous ++ [ current ]
                , current = x
                , rest = rest
                }


answer : String -> TriviaZipList -> TriviaZipList
answer val (TriviaZipList { previous, current, rest }) =
    TriviaZipList
        { previous = previous
        , current = { current | userAnswer = Just val }
        , rest = rest
        }


current : TriviaZipList -> Question
current (TriviaZipList list) =
    .current list
