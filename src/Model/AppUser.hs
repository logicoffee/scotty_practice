{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.AppUser where

import           Database.HDBC.Query.TH          (defineTableFromDB')
import           Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import           GHC.Generics                    (Generic)
import           Model.DB                        (connectPG)

defineTableFromDB'
    connectPG
    driverPostgreSQL
    "public"
    "app_user"
    [("id", [t|Int|])]
    [''Show, ''Generic]
