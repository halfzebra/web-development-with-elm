module Decoders exposing (..)

import Test exposing (Test, describe, test)
import Expect
import Json.Decode
import Data.Question exposing (Question)
import Request.TriviaQuestions exposing (TriviaResult)


suite : Test
suite =
    test "Request.TriviaQuestions.decoder can decode correct JSON"
        (\_ ->
            let
                input =
                    """
                    {
                       "response_code": 0,
                       "results":[{
                       "question": "Testting decoders is quite easy",
                       "correct_answer":"True",
                        "incorrect_answers":[
                           "False"
                        ]}]
                    }
                    """

                decodedOutput =
                    Json.Decode.decodeString Request.TriviaQuestions.decoder input
            in
                Expect.equal
                    decodedOutput
                    (Ok
                        (TriviaResult 0
                            [ Question
                                Nothing
                                "Testting decoders is quite easy"
                                "True"
                                [ "False" ]
                            ]
                        )
                    )
        )
