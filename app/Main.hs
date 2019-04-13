module Main where

import           Data.Acid
import           Web.App
import           Web.Scotty
import           Web.ServerSession.Backend.Acid
import           Web.ServerSession.Frontend.Wai

import           Data.ByteString                (ByteString)
import           Data.Text                      (Text)
import qualified Data.Vault.Lazy                as V
import           Network.Wai.Session            (Session)

main :: IO ()
main = do
    key <- V.newKey :: IO (V.Key (Session IO Text ByteString))
    sto <- AcidStorage <$> openLocalState emptyState
    session <- withServerSession key id sto

    scotty 3000 $ do
        middleware session
        app key
