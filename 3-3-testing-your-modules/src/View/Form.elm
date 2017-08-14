module View.Form exposing (group, input)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (class)


group : List (Html msg) -> Html msg
group children =
    div [ class "form-group" ] children


input : List (Attribute msg) -> Html msg
input attributes =
    Html.input ((class "form-control") :: attributes) []
