{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.AppUser.Entity where

import           Data.Text                       (Text)
import           Database.HDBC.Query.TH          (defineTableFromDB')
import           Database.HDBC.Schema.Driver     (Driver (..))
import           Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import           GHC.Generics                    (Generic)
import           Model.DB                        (connectPG)

defineTableFromDB'
    connectPG
    driverPostgreSQL { typeMap = [("text", [t|Text|])] }
    "public"
    "app_user"
    [("id", [t|Int|])]
    [''Show, ''Generic]
