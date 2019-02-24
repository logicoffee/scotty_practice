{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.AppUser where

import           Database.HDBC.Query.TH (defineTableFromDB)
import           GHC.Generics           (Generic)
import           Model.DB               (connectPG, driverPG)

defineTableFromDB
    connectPG
    driverPG
    "public"
    "app_user"
    [''Show, ''Generic]
