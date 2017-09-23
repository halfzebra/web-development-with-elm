module Request.TriviaQuestions exposing (..)

import Json.Decode exposing (Decoder, field, int, list)
import Data.Question exposing (Question)


type alias TriviaResult =
    { code : Int
    , questions : List Question
    }


decoder : Decoder TriviaResult
decoder =
    Json.Decode.map2
        TriviaResult
        (field "response_code" int)
        (field "results" (list Data.Question.decoder))
