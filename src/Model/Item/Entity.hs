{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.Item.Entity where

import           Data.Text                       (Text)
import           Database.HDBC.Query.TH          (defineTableFromDB')
import           Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import           GHC.Generics                    (Generic)
import           Model.DB                        (connectPG)

defineTableFromDB'
    connectPG
    driverPostgreSQL
    "public"
    "item"
    [
        ("id", [t|Int|]),
        ("user_id", [t|Int|]),
        ("hot_level", [t|Int|]),
        ("amazon_asin", [t|Text|])
    ]
    [''Show, ''Generic]

data Item' = Item'
    { pUserId    :: !(Maybe Int)
    , pAmazonUrl :: !String
    , pHotLevel  :: !Int
    } deriving (Generic)

piItem :: Pi Item Item'
piItem = Item'
    |$| userId'
    |*| amazonUrl'
    |*| hotLevel'

makeRelationalRecord ''Item'
