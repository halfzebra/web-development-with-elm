module Decoders exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Json.Decode
import Data.Question exposing (Question)
import Request.TriviaQuestions exposing (TriviaResult)


success : Result a b -> Bool
success result =
    case result of
        Ok _ ->
            True

        Err _ ->
            False


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
                           "question":"Studio Ghibli is a Japanese animation studio responsible for the films &quot;Wolf Children&quot; and &quot;The Boy and the Beast&quot;.",
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
                                "Studio Ghibli is a Japanese animation studio responsible for the films \"Wolf Children\" and \"The Boy and the Beast\"."
                                "False"
                                [ "True" ]
                            )
                        )
            )
        , test "Request.TriviaQuestions.decoder fails on non-zero code"
            (\_ ->
                let
                    input =
                        """
                        {
                           "response_code":1,
                           "results":[]
                        }
                        """

                    decodedOutput =
                        Json.Decode.decodeString Request.TriviaQuestions.decoder input
                in
                    Expect.equal (success decodedOutput) False
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
