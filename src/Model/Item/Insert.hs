module Model.Item.Insert where

import           Data.Functor.ProductIsomorphic.Class ((|$|), (|*|))
import           Database.HDBC                        (commit)
import           Database.HDBC.Record.Insert          (runInsert)
import           Database.Relational.Type             (insert)
import           Model.DB                             (connectPG)
import           Model.Item.Entity

singleInsert :: Item' -> IO ()
singleInsert item = do
    conn <- connectPG
    print =<< runInsert conn (insert piItem) item
    commit conn
