{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.Item where

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
        ("hot_level", [t|Int|])
    ]
    [''Show, ''Generic]
