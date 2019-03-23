module Model.Item.Query where

import           Database.HDBC.Record.Query (runQuery')
import           Model.AppUser.Entity
import           Model.DB                   (connectPG)
import           Model.Item.Entity
import           Util                       (safeHead)

findById :: Int -> IO (Maybe Item)
findById itemId = do
    conn <- connectPG
    items <- runQuery' conn selectItem itemId
    return $ safeHead items

findByAppUser :: AppUser -> IO [Item]
findByAppUser user = do
    conn <- connectPG
    return $ runQuery' conn selectItem (Model.AppUser.Entity.id user)
