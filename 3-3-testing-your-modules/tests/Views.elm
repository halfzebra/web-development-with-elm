module Views exposing (..)

import Html exposing (div)
import Test exposing (Test, test, fuzz)
import Fuzz exposing (string)
import Test.Html.Query
import Test.Html.Selector exposing (text, tag)
import View.Button


suite : Test
suite =
    fuzz string "Button always renders the label" <|
        (\label ->
            div [] [ View.Button.btn (\_ -> never) label ]
                |> Test.Html.Query.fromHtml
                |> Test.Html.Query.find [ tag "button" ]
                |> Test.Html.Query.has [ text label ]
        )
