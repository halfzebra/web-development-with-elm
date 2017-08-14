module Main exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (style, type_, value)
import Data.Difficulty exposing (Difficulty)
import Data.Question exposing (Question)
import View.Question
import View.Difficulty
import View.Form
import Util exposing ((=>), onChange)


type alias Model =
    { difficulty : Difficulty
    , amount : Int
    , questions : List Question
    }


init : Model
init =
    Model Data.Difficulty.default
        5
        [ Question
            "Why did the chicken cross the road?"
            "To get to the other side"
            [ "I don't know" ]
        ]


type Msg
    = Answer String
    | ChangeDifficulty Difficulty
    | UpdateAmount String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateAmount str ->
            case String.toInt str of
                Ok val ->
                    if val < 50 then
                        { model | amount = val }
                    else
                        { model | amount = 50 }

                _ ->
                    model

        ChangeDifficulty lvl ->
            { model | difficulty = lvl }

        _ ->
            model


view : Model -> Html Msg
view { questions, amount, difficulty } =
    div
        [ style
            [ "max-width" => "300px"
            , "margin" => "0 auto"
            ]
        ]
        [ View.Form.input
            [ value (toString amount)
            , onChange UpdateAmount
            , type_ "number"
            , Html.Attributes.min (toString 1)
            , Html.Attributes.max (toString 50)
            ]
        , View.Difficulty.select difficulty ChangeDifficulty
        , div
            [ style [ "text-align" => "center" ] ]
            (List.map ((flip View.Question.view) Answer) questions)
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
