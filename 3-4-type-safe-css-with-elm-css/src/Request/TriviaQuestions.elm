module Request.TriviaQuestions exposing (TriviaResult, get, decoder)

import Json.Decode exposing (Decoder, field, map2, list, int)
import Data.Question exposing (Question)
import Data.Difficulty exposing (Difficulty, isAny)
import Http exposing (Error)
import Util exposing ((=>), appendIf)
import Request.Helpers exposing (queryString)


type alias TriviaResult =
    { responseCode : Int
    , questions : List Question
    }


apiUrl : String -> String
apiUrl str =
    "https://opentdb.com/api.php" ++ str


responseCodeDecoder : Decoder Int
responseCodeDecoder =
    int
        |> Json.Decode.andThen
            (\val ->
                if val /= 0 then
                    Json.Decode.fail "Failed to retrieve Trivia Questions"
                else
                    Json.Decode.succeed val
            )


decoder : Decoder TriviaResult
decoder =
    map2 TriviaResult
        (field "response_code" responseCodeDecoder)
        (field "results" (list Data.Question.decoder))


triviaRequestUrl : Int -> Difficulty -> String
triviaRequestUrl amount difficulty =
    let
        difficultyValue : String
        difficultyValue =
            String.toLower (Data.Difficulty.toString difficulty)

        shouldAppend : Bool
        shouldAppend =
            not (isAny difficulty)

        queryParameterToAppend : ( String, String )
        queryParameterToAppend =
            ("difficulty" => difficultyValue)
    in
        [ "amount" => (toString amount) ]
            |> appendIf shouldAppend queryParameterToAppend
            |> queryString
            |> apiUrl


get : Int -> Difficulty -> (Result Error TriviaResult -> msg) -> Cmd msg
get amount difficulty msg =
    Http.get (triviaRequestUrl amount difficulty) decoder
        |> Http.send msg
