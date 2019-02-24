{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.Item where

import           Database.HDBC.Query.TH (defineTableFromDB)
import           GHC.Generics           (Generic)
import           Model.DB               (connectPG, driverPG)

defineTableFromDB
    connectPG
    driverPG
    "public"
    "item"
    [''Show, ''Generic]
