module SharedStyles exposing (CssClasses(..), triviaNamespace)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = ConfigForm
    | TriviaContainer


triviaNamespace =
    withNamespace "trivia"
