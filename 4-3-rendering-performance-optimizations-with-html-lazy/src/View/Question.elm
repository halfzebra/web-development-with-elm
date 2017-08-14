module View.Question exposing (view)

import Html exposing (Html, div, button, text)
import Data.Question exposing (Question)
import View.Button
import View.Form


view : Question -> (String -> msg) -> Html msg
view { question, correct, incorrect } answerMsg =
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
