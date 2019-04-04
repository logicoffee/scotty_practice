{-# LANGUAGE OverloadedStrings #-}
module Web.Route where

import           Web.Action.Signup
import           Web.Scotty

route :: ScottyM ()
route = post "/signup" signupAction
