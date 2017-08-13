module Data.Question exposing (Question)


type alias Question =
    { question : String
    , correct : String
    , incorrect : List String
    }
