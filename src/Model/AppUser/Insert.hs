{-# LANGUAGE OverloadedStrings #-}
module Model.AppUser.Insert where

import           Control.Monad.IO.Class      (liftIO)
import           Control.Monad.Trans.Except
import           Data.Text.Lazy
import           Database.HDBC               (commit)
import           Database.HDBC.Record.Insert (runInsert)
import           Database.Relational.Type    (insert)
import           Model.AppUser.Entity
import           Model.AppUser.Query
import           Model.DB                    (connectPG)
import           Model.Error

singleInsert :: AppUser' -> ExceptT Error IO AppUserResponse
singleInsert appUser = do
    maybeU <- liftIO $ do
        conn <- connectPG
        runInsert conn (insert piAppUser) appUser
        commit conn
        findByName $ pName appUser
    case maybeU of
        Nothing -> throwE $ Error ["insertion failed"]
        Just u  -> return $ AppUserResponse (Model.AppUser.Entity.id u) (Model.AppUser.Entity.name u)

trySignup :: TmpAppUser -> ExceptT Error IO AppUserResponse
trySignup tmpU = do
    maybeU <- liftIO $ findByName $ tmpName tmpU
    case maybeU of
        Just _  -> throwE $ Error ["this name is already taken"]
        Nothing -> do
            u <- ExceptT . return $ makeAppUser' tmpU
            singleInsert u
