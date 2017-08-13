module View.Button exposing (btn)

import Html exposing (Html, text, button)
import Html.Attributes exposing (class)


btn : String -> Html msg
btn txt =
    button [ class "btn btn-default" ] [ text txt ]
