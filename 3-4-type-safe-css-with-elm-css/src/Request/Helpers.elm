module Request.Helpers exposing (queryString)


queryString : List ( String, String ) -> String
queryString list =
    list
        |> List.map (\( a, b ) -> a ++ "=" ++ b)
        |> String.join "&"
        |> (++) "?"
