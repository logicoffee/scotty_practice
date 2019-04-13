{-# LANGUAGE OverloadedStrings #-}
module Web.App where

import           Data.ByteString     (ByteString)
import           Data.Text           (Text)
import qualified Data.Vault.Lazy     as V
import           Network.Wai.Session (Session)
import           Web.Action.Session
import           Web.Scotty

app :: V.Key (Session IO Text ByteString) -> ScottyM ()
app key = do
    post "/signup" signupAction
    post "/signin" $ signinAction key
