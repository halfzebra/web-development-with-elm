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
