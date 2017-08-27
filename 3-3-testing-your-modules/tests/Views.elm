module Views exposing (..)

import Html exposing (div)
import Test exposing (Test, test, fuzz, describe)
import Fuzz exposing (string)
import Test.Html.Query
import Test.Html.Selector exposing (text, tag)
import View.Question
import View.Button
import Data.Question exposing (Question)


suite : Test
suite =
    describe "View tests"
        [ test "Question has the button with correct answer" <|
            \_ ->
                let
                    question =
                        Question
                            Nothing
                            "Why did the chicken cross the road?"
                            "To get to the other side"
                            []
                in
                    View.Question.view question (\_ -> never)
                        |> Test.Html.Query.fromHtml
                        |> Test.Html.Query.find [ tag "button" ]
                        |> Test.Html.Query.has [ text "To get to the other side" ]
        , fuzz string "Button always renders the label" <|
            (\label ->
                div [] [ View.Button.btn (\_ -> never) label ]
                    |> Test.Html.Query.fromHtml
                    |> Test.Html.Query.find [ tag "button" ]
                    |> Test.Html.Query.has [ text label ]
            )
        ]
