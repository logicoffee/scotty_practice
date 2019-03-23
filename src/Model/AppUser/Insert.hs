module Model.AppUser.Insert where

import           Database.HDBC               (commit)
import           Database.HDBC.Record.Insert (runInsert)
import           Database.Relational.Type    (insert)
import           Model.AppUser.Entity
import           Model.DB                    (connectPG)

-- 拡張性に欠ける.
-- TODO: idがstrictにならない方法を探す
singleInsert :: String -> IO ()
singleInsert twitter_id = do
    conn <- connectPG
    print =<< runInsert conn (insert twitterId') twitter_id
    commit conn
