module View.Question exposing (view)

import Html exposing (Html, div, button, text)
import Data.Question exposing (Question)
import View.Button
import View.Form


view : (String -> msg) -> Question -> Html msg
view answerMsg { question, correct, incorrect } =
    let
        answers : List String
        answers =
            List.sort (correct :: incorrect)
    in
        div []
            [ View.Form.group [ text question ]
            , answers
                |> List.map (\a -> View.Button.btn (answerMsg a) a)
                |> List.intersperse (text " ")
                |> View.Form.group
            ]
