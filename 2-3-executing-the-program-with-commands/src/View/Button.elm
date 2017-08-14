module View.Button exposing (btn)

import Html exposing (Html, text, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


btn : msg -> String -> Html msg
btn msg txt =
    button [ onClick msg, class "btn btn-default" ] [ text txt ]
