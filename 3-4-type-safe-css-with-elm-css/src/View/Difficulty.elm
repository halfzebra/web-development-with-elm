module View.Difficulty exposing (option, select)

import Html exposing (Html, text)
import Html.Attributes exposing (selected, value, class)
import Data.Difficulty exposing (Difficulty)
import Util exposing (onChange)


option : Difficulty -> String -> Html msg
option current key =
    Html.option
        [ selected ((Data.Difficulty.toString current) == key)
        , value key
        ]
        [ text key ]


select : Difficulty -> (Difficulty -> msg) -> Html msg
select current tagger =
    Html.select
        [ onChange (tagger << Data.Difficulty.get)
        , class "form-control"
        ]
        (List.map (option current) Data.Difficulty.keys)
