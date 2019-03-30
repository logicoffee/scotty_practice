module Util where

import           Crypto.Hash
import           Data.Text
import           Data.Text.Encoding

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

hashPassword :: Text -> Text
hashPassword ps = pack $ show digest
    where digest = hash (encodeUtf8 ps) :: Digest SHA256
