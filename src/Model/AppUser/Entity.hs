{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.AppUser.Entity where

import           Data.Text                       (Text)
import           Database.HDBC.Query.TH          (defineTableFromDB',
                                                  makeRelationalRecord)
import           Database.HDBC.Schema.Driver     (Driver (..))
import           Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import           Database.Relational.Pi          (Pi)
import           GHC.Generics                    (Generic)
import           Model.DB                        (connectPG)

defineTableFromDB'
    connectPG
    driverPostgreSQL { typeMap = [("text", [t|Text|])] }
    "public"
    "app_user"
    [("id", [t|Int|])]
    [''Show, ''Generic]

data AppUser' = AppUser'
    { name         :: !Text
    , passwordHash :: !Text
    } deriving (Generic)

piAppUser :: Pi AppUser AppUser'
piAppUser = AppUser'
    |$| name'
    |*| passwordHash'

makeRelationalRecord ''AppUser'
