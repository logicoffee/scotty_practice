{-# LANGUAGE OverloadedStrings #-}
module Web.Action.Signup where

import           Control.Monad.IO.Class (liftIO)
import           Model.AppUser.Entity
import           Model.AppUser.Insert
import           Web.Scotty

signupAction :: ActionM ()
signupAction = do
    tmpU <- TmpAppUser
        <$> param "name"
        <*> param "password"
        <*> param "password_confirmation"
    foo <- liftIO $ trySignup tmpU
    case foo of
        Left msgs -> text $ mconcat msgs
        Right uid -> text "uidを含んだjson"
