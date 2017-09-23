module Request.TriviaQuestions exposing (..)


apiUrl : String -> String
apiUrl str =
    "https://opentdb.com/api.php" ++ str
