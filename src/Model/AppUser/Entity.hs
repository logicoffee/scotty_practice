{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}

module Model.AppUser.Entity where

import           Data.Functor.ProductIsomorphic.Class ((|$|), (|*|))
import           Data.Text                            (Text)
import           Database.HDBC.Query.TH               (defineTableFromDB',
                                                       makeRelationalRecord)
import           Database.HDBC.Schema.Driver          (Driver (..))
import           Database.HDBC.Schema.PostgreSQL      (driverPostgreSQL)
import           Database.Relational.Pi               (Pi)
import           GHC.Generics                         (Generic)
import           Model.DB                             (connectPG)
import           Util

defineTableFromDB'
    connectPG
    driverPostgreSQL { typeMap = [("text", [t|Text|])] }
    "public"
    "app_user"
    [("id", [t|Int|])]
    [''Show, ''Generic]

data AppUser' = AppUser'
    { pName         :: !Text
    , pPasswordHash :: !Text
    } deriving (Generic)

data TmpAppUser = TmpAppUser
    { tmpName              :: !Text
    , password             :: !Text
    , passwordConfirmation :: !Text
    }

makeRelationalRecord ''AppUser'

piAppUser :: Pi AppUser AppUser'
piAppUser = AppUser'
    |$| name'
    |*| passwordHash'

-- TODO: バリデーションの実装
makeAppUser' :: TmpAppUser -> Either [Text] AppUser'
makeAppUser' (TmpAppUser name ps psConf)
    | ps == psConf = Right $ AppUser' name $ hashPassword ps
    | otherwise    = Left ["password confirmation doesn't match password"]
