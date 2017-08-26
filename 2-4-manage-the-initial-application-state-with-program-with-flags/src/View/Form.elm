module View.Form exposing (group)

import Html exposing (Html, div)
import Html.Attributes exposing (class)


group : List (Html msg) -> Html msg
group children =
    div [ class "form-group" ] children
