module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

-- sumTillN :: Int -> Int
-- sumTillN 1 = 1
-- sumTillN n = n + (sumTillN (n - 1))

-- -- can also be written as
-- sumTillN :: Int -> Int
-- sumTillN n = if (n == 1) then 1 else (n + (summTillN (n - 1)))

-- -- can also be written as (tail recursive)
-- sumTillN :: Int -> Int -> Int
-- sumTillN 1 acc = 1 + acc
-- sumTillN n acc = sumTillN (n - 1) (acc + n)

-- can also be written as (using case statements)
sumTillN :: Int -> Int
sumTillN n = case n of
              1 -> 1
              anythingElse -> anythingElse + (sumTillN (n - 1))

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
