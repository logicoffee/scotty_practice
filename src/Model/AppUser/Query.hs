module Model.AppUser.Query where

import           Data.Text.Lazy
import           Database.HDBC.Record.Query      (runQuery')
import           Database.Relational.Monad.Class (wheres)
import           Database.Relational.Projectable (placeholder, (!), (.=.))
import           Database.Relational.Relation    (query, relation')
import           Database.Relational.Type        (relationalQuery)
import           Model.AppUser.Entity
import           Model.DB                        (connectPG)
import           Util                            (safeHead)

findById :: Int -> IO (Maybe AppUser)
findById userId = do
    conn <- connectPG
    users <- runQuery' conn selectAppUser userId
    return $ safeHead users

findByName :: Text -> IO (Maybe AppUser)
findByName name = do
    conn <- connectPG
    users <- runQuery' conn (relationalQuery selectByName) name
    return $ safeHead users
        where
            selectByName = relation' . placeholder $ \ph -> do
                u <- query appUser
                wheres $ u ! name' .=. ph
                return u
