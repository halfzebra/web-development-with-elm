module Data.TriviaZipList
    exposing
        ( TriviaZipList
        , next
        , createTriviaZipList
        , current
        , currentIndex
        , length
        , score
        , answer
        , hasUnansweredLeft
        )

import Data.Question exposing (Question)


type TriviaZipList
    = TriviaZipList
        { previous : List Question
        , current : Question
        , rest : List Question
        }


createTriviaZipList : List Question -> TriviaZipList
createTriviaZipList list =
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


current : TriviaZipList -> Question
current (TriviaZipList list) =
    .current list


currentIndex : TriviaZipList -> Int
currentIndex (TriviaZipList { previous }) =
    (List.length previous) + 1


length : TriviaZipList -> Int
length (TriviaZipList { previous, current, rest }) =
    List.length (previous ++ [ current ] ++ rest)


score : TriviaZipList -> Int
score (TriviaZipList { previous, current, rest }) =
    List.foldl
        (\{ userAnswer, correct } acc ->
            case userAnswer of
                Just val ->
                    if val == correct then
                        acc + 1
                    else
                        acc

                _ ->
                    acc
        )
        0
        (previous ++ [ current ] ++ rest)


answer : String -> TriviaZipList -> TriviaZipList
answer val (TriviaZipList { previous, current, rest }) =
    TriviaZipList
        { previous = previous
        , current = { current | userAnswer = Just val }
        , rest = rest
        }


hasUnansweredLeft : TriviaZipList -> Bool
hasUnansweredLeft (TriviaZipList { previous, current, rest }) =
    (previous ++ [ current ] ++ rest)
        |> List.filter
            (\{ userAnswer } ->
                if userAnswer == Nothing then
                    True
                else
                    False
            )
        |> List.length
        |> (<) 0
