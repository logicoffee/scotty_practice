module Model.AppUser.Query where

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

findByTwitterId :: String -> IO (Maybe AppUser)
findByTwitterId twitterId = do
    conn <- connectPG
    users <- runQuery' conn (relationalQuery selectByTwitterId) twitterId
    return $ safeHead users
        where
            selectByTwitterId = relation' . placeholder $ \ph -> do
                u <- query appUser
                wheres $ u ! twitterId' .=. ph
                return u
