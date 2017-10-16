module Main exposing (..)

import Task exposing (Task)
import Date exposing (Date)


succeeded : Task Never Int
succeeded =
    -- Similar to Promise.resolve(1)
    Task.succeed 1


failed : Task String x
failed =
    -- Similar to Promise.reject(1)
    Task.fail "everything is broken"


now : Task x Date
now =
    Date.now
