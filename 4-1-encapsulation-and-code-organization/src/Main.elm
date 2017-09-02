port module Main exposing (..)

import Html
    exposing
        ( Html
        , text
        , input
        , select
        , option
        , div
        , h1
        , label
        )
import Html.Attributes exposing (value)
import Data.Difficulty exposing (Difficulty)
import View.Question
import View.Button
import View.Form
import Request.Helpers exposing (queryString)
import Util exposing (onChange, (=>), appendIf)
import Http exposing (Error)
import Request.TriviaQuestions exposing (TriviaResult)
import SharedStyles exposing (..)
import Data.TriviaZipList exposing (TriviaZipList)


{ class } =
    triviaNamespace


type alias GameResults =
    { score : Int
    , total : Int
    }


type alias Model =
    { amount : Int
    , difficulty : Difficulty
    , trivia : Maybe TriviaZipList
    }


init : ( Model, Cmd Msg )
init =
    ( Model
        5
        Data.Difficulty.default
        Nothing
    , Cmd.none
    )


type Msg
    = Answer String
    | UpdateAmount String
    | ChangeDifficulty Difficulty
    | Start
    | GetQuestions (Result Error TriviaResult)
    | SubmitAnswers
    | SavedGameResults (List GameResults)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "MSG: " msg of
        Answer val ->
            ( model.trivia
                |> Maybe.map (Data.TriviaZipList.answer val)
                |> Maybe.map Data.TriviaZipList.next
                |> Maybe.map (\t -> { model | trivia = Just t })
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
                apiUrl str =
                    "https://opentdb.com/api.php" ++ str

                amount =
                    toString model.amount

                flag =
                    not (Data.Difficulty.isAny model.difficulty)

                difficultyValue =
                    "difficulty" => (String.toLower (Data.Difficulty.toString model.difficulty))

                params =
                    [ "amount" => amount ]

                request =
                    Http.get
                        (params
                            |> appendIf flag difficultyValue
                            |> queryString
                            |> apiUrl
                        )
                        Request.TriviaQuestions.decoder
            in
                ( model, Http.send GetQuestions request )

        GetQuestions res ->
            case res of
                Ok { questions } ->
                    ( { model | trivia = Just (Data.TriviaZipList.fromList questions) }
                    , Cmd.none
                    )

                Err err ->
                    ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )



--
--        SubmitAnswers ->
--            let
--                length =
--                    Array.length model.questions
--
--                score =
--                    Array.foldl
--                        (\{ userAnswer, correct } acc ->
--                            case userAnswer of
--                                Just v ->
--                                    if v == correct then
--                                        acc + 1
--                                    else
--                                        acc
--
--                                Nothing ->
--                                    acc
--                        )
--                        0
--                        model.questions
--
--                res =
--                    GameResults score length
--            in
--                ( model, output res )
--
--        SavedGameResults res ->
--            ( model, Cmd.none )


view : Model -> Html Msg
view { amount, trivia } =
    div
        [ class [ TriviaContainer ] ]
        [ h1 [] [ text "Open Trivia" ]
        , div
            [ class [ ConfigForm ] ]
            [ View.Form.group
                [ label [] [ text "Amount of questions: " ]
                , input
                    [ onChange UpdateAmount
                    , value (toString amount)
                    , Html.Attributes.class "form-control"
                    ]
                    []
                ]
            , View.Form.group
                [ label [] [ text "Difficulty: " ]
                , select
                    [ onChange (ChangeDifficulty << Data.Difficulty.get)
                    , Html.Attributes.class "form-control"
                    ]
                    (List.map
                        (\key ->
                            option
                                []
                                [ text key ]
                        )
                        Data.Difficulty.keys
                    )
                ]
            , View.Button.btn Start "Start"
            ]
        , case trivia of
            Just zipList ->
                View.Question.view (Data.TriviaZipList.current zipList) Answer

            Nothing ->
                text ""

        -- , View.Button.btn SubmitAnswers "Submit"
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
