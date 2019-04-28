{-# LANGUAGE DeriveGeneric #-}

module Model.Error where

import           Data.Aeson.Types
import           Data.Text.Lazy
import           GHC.Generics

newtype Error = Error { messages :: [Text] } deriving (Generic)
instance FromJSON Error
instance ToJSON Error
