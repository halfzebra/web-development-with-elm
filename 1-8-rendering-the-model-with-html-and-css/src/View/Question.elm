module View.Question exposing (view)

import Html exposing (Html, div, button, text)
import Data.Question exposing (Question)
import View.Button
import View.Form


view : Question -> Html msg
view { question, correct, incorrect } =
    let
        answers =
            List.sort (correct :: incorrect)
    in
        div []
            [ View.Form.group [ text question ]
            , answers
                |> List.map (\a -> View.Button.btn a)
                |> List.intersperse (text " ")
                |> View.Form.group
            ]
