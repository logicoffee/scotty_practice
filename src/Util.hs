module Util where

import           Crypto.Hash
import           Data.Text.Lazy
import           Data.Text.Lazy.Encoding

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

hashPassword :: Text -> Text
hashPassword ps = pack $ show digest
    where digest = hashlazy (encodeUtf8 ps) :: Digest SHA256
