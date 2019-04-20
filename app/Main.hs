module Main where

import           Data.Acid
import qualified Data.Vault.Lazy                as LV
import           Util
import           Web.App
import           Web.Scotty
import           Web.ServerSession.Backend.Acid
import           Web.ServerSession.Frontend.Wai

main :: IO ()
main = do
    key <- LV.newKey :: IO VaultKey
    sto <- AcidStorage <$> openLocalState emptyState
    session <- withServerSession key id sto

    scotty 3000 $ do
        middleware session
        app key
