{-# LANGUAGE OverloadedStrings #-}
module Model.AppUser.Insert where

import           Control.Monad.IO.Class      (liftIO)
import           Control.Monad.Trans.Except  hiding (except)
import           Data.Text.Lazy
import           Database.HDBC               (commit)
import           Database.HDBC.Record.Insert (runInsert)
import           Database.Relational.Type    (insert)
import           Model.AppUser.Entity
import           Model.AppUser.Query
import           Model.DB                    (connectPG)

singleInsert :: AppUser' -> ExceptT [Text] IO Int
singleInsert appUser = do
    maybeU <- liftIO $ do
        conn <- connectPG
        runInsert conn (insert piAppUser) appUser
        commit conn
        findByName $ pName appUser
    case maybeU of
        Nothing -> throwE ["insertion failed"]
        Just u  -> return $ Model.AppUser.Entity.id u

trySignup :: TmpAppUser -> ExceptT [Text] IO Int
trySignup tmpU = do
    maybeU <- liftIO $ findByName $ tmpName tmpU
    case maybeU of
        Just _  -> throwE ["this name is already taken"]
        Nothing -> do
            u <- except $ makeAppUser' tmpU
            singleInsert u

except :: Monad m => Either a b -> ExceptT a m b
except = ExceptT . return
