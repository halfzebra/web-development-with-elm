module Main exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Data.Difficulty exposing (Difficulty)
import Data.Question exposing (Question)
import View.Question
import Util exposing ((=>))


type alias Model =
    { difficulty : Difficulty
    , questions : List Question
    }


init : Model
init =
    Model Data.Difficulty.default
        [ Question
            "Why did the chicken cross the road?"
            "To get to the other side"
            [ "I don't know" ]
        ]


type Msg
    = Answer String


update : Msg -> Model -> Model
update msg model =
    init


view : Model -> Html Msg
view model =
    div
        [ style [ "text-align" => "center" ] ]
        (List.map (\q -> View.Question.view q Answer) model.questions)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , update = \_ _ -> init
        , view = view
        }
