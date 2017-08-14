module View.Button exposing (btn, btnPrimary, btnSuccess)

import Html exposing (Html, text, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


btn : msg -> String -> Html msg
btn msg txt =
    button [ onClick msg, class "btn btn-default" ] [ text txt ]


btnPrimary : msg -> String -> Html msg
btnPrimary msg txt =
    button [ onClick msg, class "btn btn-primary" ] [ text txt ]


btnSuccess : msg -> String -> Html msg
btnSuccess msg txt =
    button [ onClick msg, class "btn btn-success" ] [ text txt ]
