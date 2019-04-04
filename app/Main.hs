module Main where

import           Web.Route
import           Web.Scotty

main :: IO ()
main = scotty 3000 route
