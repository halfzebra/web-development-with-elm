module Data.Question exposing (Question, decoder)

import Json.Decode exposing (Decoder, map, map3, field, list, string)
import Util exposing (replaceHtmlEntities)


type alias Question =
    { userAnswer : Maybe String
    , question : String
    , correct : String
    , incorrect : List String
    }


stringWithHtmlEntities : Decoder String
stringWithHtmlEntities =
    map replaceHtmlEntities string


decoder : Decoder Question
decoder =
    map3 (Question Nothing)
        (field "question" stringWithHtmlEntities)
        (field "correct_answer" string)
        (field "incorrect_answers" (list stringWithHtmlEntities))
