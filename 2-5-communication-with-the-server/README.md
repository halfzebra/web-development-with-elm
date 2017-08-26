# Communication with the Server

Implementing HTTP communication with the server.

This project is bootstrapped with [Create Elm App.](https://github.com/halfzebra/create-elm-app)

### `src/Main.elm`

We have added two mode messages `Start` and `GetQuestions (Result Error Value)`

```elm

-- Added new imports to Main.elm

import View.Button
import Util exposing (onChange, (=>), appendIf)
import Http exposing (Error)
import Request.TriviaQuestions
import Request.Helpers exposing (queryString)
import Json.Decode exposing (Value)

-- New handlers for update function:
  Start ->
      let
          difficultyValue =
              model.difficulty
                  |> Data.Difficulty.toString
                  |> String.toLower

          flag =
              Data.Difficulty.isAny model.difficulty
      in
          ( model
          , Http.send GetQuestions <|
              Http.get
                  (Request.TriviaQuestions.apiUrl
                      ([ "amount" => toString model.amount ]
                          |> appendIf (not flag) ("difficulty" => difficultyValue)
                          |> queryString
                      )
                  )
                  Json.Decode.value
          )

  GetQuestions res ->
      Debug.log "GetQuestions: " res
          |> \_ ->
              ( model
              , Cmd.none
              )
```

### `src/Util.elm`

A helper for conditionally appending an element to a list.

```elm
appendIf : Bool -> a -> List a -> List a
appendIf flag value list =
    if flag == True then
        list ++ [ value ]
    else
        list
```

### `src/Data/Difficulty.elm`

Add `toString` function for the Difficulty Union Type.

```elm
isAny : Difficulty -> Bool
isAny lvl =
    lvl == Any


toString : Difficulty -> String
toString lvl =
    list
        |> List.filter (\( k, v ) -> v == lvl)
        -- Maybe ( String, Difficulty )
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault "Any"
```

### `src/Request/Helpers.elm`

Add the URL of the API.

```elm
module Request.TriviaQuestions exposing (apiUrl)


apiUrl : String -> String
apiUrl str =
    "https://opentdb.com/api.php" ++ str
```

### `src/Request/Helpers.elm`

Add a helper for building query string.

```elm
module Request.Helpers exposing (queryString)


queryString : List ( String, String ) -> String
queryString list =
    list
        |> List.map (\( a, b ) -> a ++ "=" ++ b)
        |> String.join "&"
        |> (++) "?"
```
