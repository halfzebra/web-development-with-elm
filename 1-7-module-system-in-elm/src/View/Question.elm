module View.Question exposing (view)

import Data.Question exposing (Question)


view : Question -> String
view { question, correct } =
    "Question: "
        ++ question
        ++ " Answer: "
        ++ correct
