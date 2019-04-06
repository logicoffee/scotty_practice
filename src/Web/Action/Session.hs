{-# LANGUAGE OverloadedStrings #-}
module Web.Action.Session where

import           Control.Monad.IO.Class     (liftIO)
import           Control.Monad.Trans.Except
import           Data.Aeson.Types
import           Data.Scientific            (scientific)
import qualified Data.Text.Lazy             as T
import           Model.AppUser.Entity
import           Model.AppUser.Insert
import           Web.Scotty

signupAction :: ActionM ()
signupAction = do
    tmpU <- TmpAppUser
        <$> param "name"
        <*> param "password"
        <*> param "password_confirmation"
    result <- liftIO $ runExceptT $ trySignup tmpU
    case result of
        Left msgs -> json $ object ["errors" .= map T.toStrict msgs]
        Right uid -> json $ object ["user_id" .= Number (scientific (toInteger uid) 0)]