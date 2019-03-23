{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.Item.Insert where

import           Data.Functor.ProductIsomorphic.Class ((|$|), (|*|))
import           Database.HDBC                        (commit)
import           Database.HDBC.Query.TH               (makeRelationalRecord)
import           Database.HDBC.Record.Insert          (runInsert)
import           Database.Relational.Pi               (Pi)
import           Database.Relational.Type             (insert)
import           GHC.Generics                         (Generic)
import           Model.DB                             (connectPG)
import           Model.Item.Entity

singleInsert :: Item' -> IO ()
singleInsert item = do
    conn <- connectPG
    print =<< runInsert conn (insert piItem) item
    commit conn

piItem :: Pi Item Item'
piItem = Item'
    |$| userId'
    |*| amazonUrl'
    |*| hotLevel'

data Item' = Item'
    { pUserId    :: !(Maybe Int)
    , pAmazonUrl :: !String
    , pHotLevel  :: !Int
    } deriving (Generic)

makeRelationalRecord ''Item'
