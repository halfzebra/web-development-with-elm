port module Main exposing (..)

import Html
    exposing
        ( Html
        , text
        , input
        , select
        , option
        , div
        )
import Html.Attributes exposing (value)
import Array exposing (Array)
import Data.Difficulty exposing (Difficulty)
import Data.Question exposing (Question)
import View.Question
import Util exposing (onChange, (=>), appendIf)
import Request.TriviaQuestions exposing (TriviaResults)
import Request.Helpers exposing (queryString)
import View.Button
import Http exposing (Error)


type alias GameResults =
    { score : Int
    , total : Int
    }


type alias Model =
    { amount : Int
    , difficulty : Difficulty
    , questions : Array Question
    }


init : ( Model, Cmd Msg )
init =
    ( Model
        5
        Data.Difficulty.default
        Array.empty
    , Cmd.none
    )


type Msg
    = Answer Int String
    | UpdateAmount String
    | ChangeDifficulty Difficulty
    | Start
    | GetQuestions (Result Error TriviaResults)
    | SubmitAnswers
    | SavedGameResults (List GameResults)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "MSG: " msg of
        Answer i val ->
            ( model.questions
                -- Maybe Question
                |> Array.get i
                -- Maybe Question
                |> Maybe.map
                    (\q -> { q | userAnswer = Just val })
                -- Maybe (Array Question)
                |> Maybe.map
                    (\q -> Array.set i q model.questions)
                -- Maybe Model
                |> Maybe.map (\arr -> { model | questions = arr })
                |> Maybe.withDefault model
            , Cmd.none
            )

        UpdateAmount str ->
            case String.toInt str of
                Ok val ->
                    if val > 50 then
                        ( { model | amount = 50 }
                        , Cmd.none
                        )
                    else
                        ( { model | amount = val }
                        , Cmd.none
                        )

                Err err ->
                    ( model
                    , Cmd.none
                    )

        ChangeDifficulty lvl ->
            ( { model | difficulty = lvl }
            , Cmd.none
            )

        Start ->
            let
                difficultyValue =
                    model.difficulty
                        |> Data.Difficulty.toString
                        |> String.toLower

                flag =
                    Data.Difficulty.isAny model.difficulty
            in
                ( model
                , Http.send GetQuestions <|
                    Http.get
                        (Request.TriviaQuestions.apiUrl
                            ([ "amount" => toString model.amount ]
                                |> appendIf (not flag)
                                    ("difficulty" => difficultyValue)
                                |> queryString
                            )
                        )
                        Request.TriviaQuestions.decoder
                )

        GetQuestions res ->
            ( case res of
                Ok { questions } ->
                    { model | questions = Array.fromList questions }

                Err err ->
                    model
            , Cmd.none
            )

        SubmitAnswers ->
            let
                length =
                    Array.length model.questions

                score =
                    Array.foldl
                        (\{ userAnswer, correct } acc ->
                            case userAnswer of
                                Just v ->
                                    if v == correct then
                                        acc + 1
                                    else
                                        acc

                                Nothing ->
                                    acc
                        )
                        0
                        model.questions

                res =
                    GameResults score length
            in
                ( model, output res )

        SavedGameResults res ->
            ( model, Cmd.none )


view : Model -> Html Msg
view { amount, questions } =
    div
        []
        [ input
            [ onChange UpdateAmount
            , value (toString amount)
            ]
            []
        , select
            [ onChange (ChangeDifficulty << Data.Difficulty.get) ]
            (List.map
                (\key ->
                    option
                        []
                        [ text key ]
                )
                Data.Difficulty.keys
            )
        , View.Button.btn Start "Start"
        , div
            []
            (questions
                |> Array.indexedMap
                    (\i q -> View.Question.view (Answer i) q)
                |> Array.toList
            )
        , View.Button.btn SubmitAnswers "Submit"
        ]


port output : GameResults -> Cmd msg


port incoming : (List GameResults -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    incoming SavedGameResults


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
