{-# LANGUAGE OverloadedStrings #-}
module Model.AppUser.Insert where

import           Data.Text.Lazy
import           Database.HDBC               (commit)
import           Database.HDBC.Record.Insert (runInsert)
import           Database.Relational.Type    (insert)
import           Model.AppUser.Entity
import           Model.AppUser.Query
import           Model.DB                    (connectPG)

singleInsert :: AppUser' -> IO (Either [Text] Int)
singleInsert appUser = do
    conn <- connectPG
    runInsert conn (insert piAppUser) appUser
    commit conn
    maybeU <- findByName $ pName appUser
    case maybeU of
        Nothing -> return $ Left ["insertion failed"]
        Just u  -> return $ Right $ Model.AppUser.Entity.id u

trySignup :: TmpAppUser -> IO (Either [Text] Int)
trySignup tmpU = do
    maybeU <- findByName $ tmpName tmpU
    case maybeU of
        Just _  -> return $ Left ["this name is already taken"]
        Nothing ->
            case makeAppUser' tmpU of
                Left msgs -> return $ Left msgs
                Right u   -> singleInsert u
