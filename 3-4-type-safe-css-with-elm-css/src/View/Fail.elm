module View.Fail exposing (view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class, attribute)


view : String -> Html msg
view err =
    div
        [ class "alert alert-danger"
        , attribute "role" "alert"
        ]
        [ text err ]
