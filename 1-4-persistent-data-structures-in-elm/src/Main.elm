module Main exposing (..)

import Html exposing (text)
import Set
import Array
import Dict


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


list =
    1 :: [ 2 ] ++ [ 3 ]


transformList list =
    list
        |> List.map (\a -> a + 1)
        |> List.map toString
        |> String.join ", "


set =
    Set.fromList (list)


transformSet set =
    set
        |> Set.map (\a -> a + 1)
        |> Set.map toString
        |> Set.toList
        |> String.join ", "


array =
    Array.empty
        |> Array.push 1
        |> Array.push 2
        |> Array.push 3


transformArray array =
    array
        |> Array.get 1
        |> toString


(=>) =
    (,)


dict =
    Dict.fromList
        [ "question" => "Why did the chicken cross the road?"
        , "answer" => "To get to the other side"
        ]


transformDict dict =
    Dict.update
        "answer"
        (\a -> (Maybe.map String.toUpper) a)
        dict


main =
    -- view init
    dict
        |> transformDict
        |> toString
        |> text
