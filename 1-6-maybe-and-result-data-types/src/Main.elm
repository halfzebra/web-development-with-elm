module Main exposing (..)

import Html exposing (Html, text)
import Maybe
import Result


-- Maybe for representing the data that might be absent:


maybeMessage : Maybe String
maybeMessage =
    -- Nothing
    Just ("Elm first appeared in ")


unwrapMaybeMessage : Maybe String -> String
unwrapMaybeMessage mb =
    Maybe.withDefault "Sorry, there's no message" mb



{- Alternative implementations with pattern matching:

   unwrapMaybeMessage mb =
       case mb of
           Just x ->
               x

           Nothing ->
               "Sorry, there's no message"


   unwrapMaybeMessage mb =
       if mb == Just x then
           x
       else
           "Sorry, there's no message"
-}


parsedYear : Result String Int
parsedYear =
    String.toInt "2012"



-- Alternative way of unwrapping Result x a with pattern matching


parsedYearVal : String
parsedYearVal =
    case parsedYear of
        Ok x ->
            toString x

        Err err ->
            Debug.crash "I don't know when elm was created!"


main : Html msg
main =
    let
        maybeParsedYear : Maybe String
        maybeParsedYear =
            Maybe.map toString (Result.toMaybe (parsedYear))

        fullMessage : String
        fullMessage =
            maybeMessage
                |> Maybe.map2 (\a b -> b ++ a) maybeParsedYear
                |> Maybe.map String.toUpper
                |> unwrapMaybeMessage
    in
        -- text parsedYearVal
        text fullMessage
