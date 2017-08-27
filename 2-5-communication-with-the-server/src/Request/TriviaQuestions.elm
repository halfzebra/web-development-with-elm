module Request.TriviaQuestions exposing (apiUrl)


apiUrl : String -> String
apiUrl str =
    "https://opentdb.com/api.php" ++ str
