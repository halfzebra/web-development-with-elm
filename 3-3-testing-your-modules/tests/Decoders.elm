module Decoders exposing (..)

import Test exposing (Test, describe, test)
import Expect
import Json.Decode
import Data.Question exposing (Question)
import Request.TriviaQuestions exposing (TriviaResult)


suite : Test
suite =
    describe "Decoders for retrieviong Trivia Questions"
        [ test "Data.Question.decoder can decode a question with HTML special characters"
            (\_ ->
                let
                    input =
                        """
                        {
                           "category":"Entertainment: Japanese Anime & Manga",
                           "type":"boolean",
                           "difficulty":"easy",
                           "question":"Studio Ghibli is a Japanese animation studio responsible for the films Wolf Children and The Boy and the Beast.",
                           "correct_answer":"False",
                           "incorrect_answers":[
                              "True"
                           ]
                        }
                        """

                    decodedOutput =
                        Json.Decode.decodeString Data.Question.decoder input
                in
                    Expect.equal decodedOutput
                        (Ok
                            (Question
                                Nothing
                                "Studio Ghibli is a Japanese animation studio responsible for the films Wolf Children and The Boy and the Beast."
                                "False"
                                [ "True" ]
                            )
                        )
            )
        , test "Request.TriviaQuestions.decoder can decode correct JSON"
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
                            (TriviaResult
                                0
                                [ (Question Nothing "Testting decoders is quite easy" "True" [ "False" ]) ]
                            )
                        )
            )
        ]
