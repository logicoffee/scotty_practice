module Util where

import           Crypto.Hash
import qualified Data.ByteString         as SB
import qualified Data.Text               as ST
import qualified Data.Text.Lazy          as LT
import           Data.Text.Lazy.Encoding
import           Data.Vault.Lazy         (Key)
import           Network.Wai.Session     (Session)

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

hashPassword :: LT.Text -> LT.Text
hashPassword ps = LT.pack $ show digest
    where digest = hashlazy (encodeUtf8 ps) :: Digest SHA256

type VaultKey = Key (Session IO ST.Text SB.ByteString)
