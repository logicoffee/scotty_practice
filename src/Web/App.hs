{-# LANGUAGE OverloadedStrings #-}
module Web.App where

import           Util
import           Web.Action.Session
import           Web.Scotty

app :: VaultKey -> ScottyM ()
app key = do
    post "/signup" signupAction
    post "/signin" $ signinAction key
