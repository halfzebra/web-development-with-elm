module Main exposing (..)

import Html exposing (Html, text, div, label, select, option, input, h1)
import Html.Attributes exposing (value, type_, selected, class, attribute, style)
import Html.Lazy
import Http exposing (Error)
import Data.TriviaZipList exposing (TriviaZipList)
import Data.Difficulty exposing (Difficulty(..))
import View.Question
import View.Loading
import View.Finish
import View.Button
import View.Fail
import View.Form
import View.Difficulty
import Request.TriviaQuestions exposing (TriviaResult)
import Util exposing (onChange, (=>))


-- MODEL


type GameState
    = Config { amount : Int, difficulty : Difficulty }
    | Loading
    | Playing TriviaZipList
    | Finish GameResults
    | Fail String


type alias Model =
    { state : GameState }


type alias GameResults =
    { score : Int, total : Int }


init : ( Model, Cmd Msg )
init =
    ( Model (Config { amount = 5, difficulty = Data.Difficulty.default })
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp
    | UpdateAmount Int
    | Start
    | GetQuestions (Result Error TriviaResult)
    | Answer String
    | SubmitAnswers
    | Restart
    | Skip
    | ChangeDifficulty Difficulty
    | UpdateTimer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.state ) of
        ( UpdateAmount value, Config values ) ->
            ( { model | state = Config { values | amount = value } }
            , Cmd.none
            )

        ( Start, Config { amount, difficulty } ) ->
            ( { model | state = Loading }
            , Request.TriviaQuestions.get amount difficulty GetQuestions
            )

        ( GetQuestions res, Loading ) ->
            case res of
                Ok { questions } ->
                    let
                        triviaZipList : TriviaZipList
                        triviaZipList =
                            Data.TriviaZipList.createTriviaZipList questions
                    in
                        ( { model | state = Playing triviaZipList }
                        , Cmd.none
                        )

                Err err ->
                    ( { model | state = Fail (toString err) }
                    , Cmd.none
                    )

        ( Answer value, Playing zipList ) ->
            ( { model
                | state =
                    Playing
                        (zipList
                            |> Data.TriviaZipList.answer value
                            |> Data.TriviaZipList.next
                        )
              }
            , Cmd.none
            )

        ( SubmitAnswers, Playing zipList ) ->
            let
                getGameResults : GameResults
                getGameResults =
                    GameResults
                        (Data.TriviaZipList.score zipList)
                        (Data.TriviaZipList.length zipList)
            in
                ( { model | state = Finish getGameResults }
                , Cmd.none
                )

        ( Skip, Playing zipList ) ->
            ( { model | state = Playing (Data.TriviaZipList.next zipList) }
            , Cmd.none
            )

        ( Restart, _ ) ->
            init

        ( ChangeDifficulty difficulty, Config val ) ->
            ( { model | state = Config { val | difficulty = difficulty } }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )



-- VIEW


amountTagger : Result String Int -> Msg
amountTagger res =
    case res of
        Ok value ->
            UpdateAmount value

        Err err ->
            NoOp


view : Model -> Html Msg
view { state } =
    div
        [ class "container"
        , style [ ( "text-align", "center" ) ]
        ]
        [ h1 [] [ text "Open Trivia" ]
        , case state of
            Config { amount, difficulty } ->
                div
                    [ style
                        [ "max-width" => "300px"
                        , "margin" => "0 auto"
                        ]
                    ]
                    [ View.Form.group
                        [ label [] [ text "Amount of questions" ]
                        , View.Form.input
                            [ value (toString amount)
                            , onChange (amountTagger << String.toInt)
                            , type_ "number"
                            , Html.Attributes.min (toString 1)
                            , Html.Attributes.max (toString 50)
                            ]
                        ]
                    , View.Form.group
                        [ label [] [ text "Difficulty" ]
                        , View.Difficulty.select difficulty ChangeDifficulty
                        ]
                    , View.Button.btn Start "Start"
                    ]

            Playing list ->
                let
                    current =
                        Data.TriviaZipList.current list

                    length =
                        list
                            |> Data.TriviaZipList.length
                            |> toString

                    currentIndex =
                        list
                            |> Data.TriviaZipList.currentIndex
                            |> toString
                in
                    div
                        []
                        [ View.Form.group
                            [ View.Button.btnPrimary Restart "Start over" ]
                        , (Html.Lazy.lazy text) (currentIndex ++ "/" ++ length)
                        , View.Question.view current Answer
                        , View.Form.group [ View.Button.btn Skip "Skip" ]
                        , View.Button.btnSuccess SubmitAnswers "Submit answers"
                        ]

            Loading ->
                View.Loading.view

            Finish { score, total } ->
                (Html.Lazy.lazy3 View.Finish.view)
                    (toString score)
                    (toString total)
                    Restart

            Fail err ->
                (Html.Lazy.lazy View.Fail.view) err
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
