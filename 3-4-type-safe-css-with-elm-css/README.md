# Type safe CSS with elm-css

Use the power of Type inference to ensure the correctness of the styles in your application.

## Changes

### `src/index.js`

Import the compiled stylesheet.

```js
import './main.css';
```

###  `src/SharedStyles.elm`

```elm
module SharedStyles exposing (CssClasses(..), triviaNamespace)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = ConfigForm
    | TriviaContainer


triviaNamespace =
    withNamespace "trivia"
```

### `src/Stylesheets.elm`

The module, that controls the compilation of CSS file.

```elm
port module Stylesheets exposing (..)

import Css.File exposing (CssCompilerProgram, CssFileStructure)
import TriviaCss


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "src/main.css", Css.File.compile [ TriviaCss.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
```

### `src/TriviaCss.elm`

The actual stylesheet witht CSS rules.

```elm
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

```

## Running the example

```bash
npm install elm-css -g
elm-app install rtfeldman/elm-css -y
elm-app install rtfeldman/elm-css-helpers -y
elm-css src/Stylesheets.elm
elm-app build
```

This project is bootstrapped with [Create Elm App.](https://github.com/halfzebra/create-elm-app)
