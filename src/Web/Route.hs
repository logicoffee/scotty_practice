{-# LANGUAGE OverloadedStrings #-}
module Web.Route where

import           Web.Action.Session
import           Web.Scotty

route :: ScottyM ()
route = post "/signup" signupAction
