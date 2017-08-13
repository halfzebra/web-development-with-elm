module Main exposing (..)

import Html exposing (text)


-- Using Tuples


questionTuple =
    ( "Why did the chicken cross the road?", "To get to the other side" )


anotherQuestionTuple =
    ( Tuple.first questionTuple, "It was too far to walk around" )


questionTupleView ( question, answer ) =
    text ("Question: " ++ question ++ " Answer: " ++ answer)


tupleWithDfifferentTypes x str =
    ( x, str )


(=>) =
    (,)



-- Using Records


questionRecord =
    { question = "Why did the chicken cross the road?"
    , answer = "To get to the other side"
    }


anotherQuestionRecord =
    { questionRecord | answer = "It was too far to walk around" }


questionRecordView { question, answer } =
    text ("Question: " ++ question ++ " Answer: " ++ answer)



{- Alternative implementation without destructuring:

   questionRecordView model =
       text ("Question: " ++ model.question ++ " Answer: " ++ model.answer)
       --    text ("Question: " ++ (.question model) ++ " Answer: " ++ (.answer model))

-}


main =
    -- questionRecordView questionRecord
    questionTupleView questionTuple
