module Model.Item.Insert where

import           Database.HDBC               (commit)
import           Database.HDBC.Record.Insert (runInsert)
import           Database.Relational.Type    (insert)
import           Model.DB                    (connectPG)
import           Model.Item.Entity

singleInsert :: Item' -> IO ()
singleInsert i = do
    conn <- connectPG
    print =<< runInsert conn (insert piItem) i
    commit conn
