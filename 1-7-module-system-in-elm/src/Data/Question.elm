module Data.Question exposing (Question)


type alias Question =
    { userAnswer : Maybe String
    , question : String
    , correct : String
    , incorrect : List String
    }
