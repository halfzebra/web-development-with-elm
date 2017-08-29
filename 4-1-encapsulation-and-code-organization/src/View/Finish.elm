module View.Finish exposing (view)

import Html exposing (Html, div, button, text)
import View.Button
import View.Form


view : String -> String -> msg -> Html msg
view score total restartMsg =
    let
        message : String
        message =
            String.join " "
                [ "Your score is:"
                , score
                , "out of"
                , total
                ]
    in
        div []
            [ text message
            , View.Form.group
                [ View.Button.btnPrimary restartMsg "Start over" ]
            ]
