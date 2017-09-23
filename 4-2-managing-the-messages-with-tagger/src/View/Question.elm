module View.Question exposing (view)

import Html exposing (Html, div, text)
import Data.Question exposing (Question)
import View.Button
import View.Form


view : Question -> (String -> msg) -> Html msg
view { question, correct, incorrect } msg =
    let
        answers =
            List.sort (correct :: incorrect)
    in
        div
            []
            [ View.Form.group [ text question ]
            , answers
                |> List.map
                    (\a -> View.Button.btn (msg a) a)
                |> List.intersperse (text " ")
                |> View.Form.group
            ]
