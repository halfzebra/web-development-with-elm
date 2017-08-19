module View.Question exposing (view)

import Html exposing (Html, div, text)
import Data.Question exposing (Question)
import View.Button
import View.Form


view : (String -> msg) -> Question -> Html msg
view msg { question, correct, incorrect } =
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
