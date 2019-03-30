module Model.AppUser.Insert where

import           Database.HDBC               (commit)
import           Database.HDBC.Record.Insert (runInsert)
import           Database.Relational.Type    (insert)
import           Model.AppUser.Entity
import           Model.DB                    (connectPG)

-- TmpAppUser -> IO a じゃなくていいのか要検討
singleInsert :: AppUser' -> IO Int
singleInsert appUser = do
    conn  <- connectPG
    count <- runInsert conn (insert piAppUser) appUser
    commit conn
    return $ fromInteger count
