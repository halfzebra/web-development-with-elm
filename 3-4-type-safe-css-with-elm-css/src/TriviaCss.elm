module TriviaCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import SharedStyles exposing (triviaNamespace, CssClasses(..))


css =
    (stylesheet << namespace triviaNamespace.name)
        [ class ConfigForm
            [ maxWidth (px 300)
            , margin2 (px 0) auto
            ]
        , class TriviaContainer
            [ textAlign center ]
        ]
