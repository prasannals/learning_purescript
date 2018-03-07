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

-- don't worry too much about "forall a.". We'll learn what that is soon.
isEmpty :: forall a. (Array a) -> Boolean
isEmpty [] = true  -- matches empty array
isEmpty _ = false  -- matches everything else

-- this function only multiplies the middle two numbers in an array of length 4
-- if the first and last number are both either 0 or 1
mulMid :: Array Int -> Int
mulMid [0, a, b, 0] = a * b
mulMid [1, a, b, 1] = a * b
mulMid _ = 0

type Product = {name :: String, category :: String, price :: Number}
type Order = {id :: Int, product :: Product}

productStr :: forall r. {name :: String, category :: String, price :: Number | r} -> String
productStr {name : n, category : c, price : p} = n <> " : " <> c <> " : " <> (show $ p)

-- orderStr :: {id :: Int, product :: {name :: String, category :: String, price :: Number}} -> String
-- orderStr {id : id, product : {name : n, category : c, price : p}} = (show id) <> ", " <> (productStr {name : n, category : c, price : p})

-- Same thing, but we name the pattern here
orderStr :: {id :: Int, product :: {name :: String, category :: String, price :: Number}} -> String
orderStr order@{id : id, product : prod@{name : n, category : c, price : p}} = (show id) <> ", " <> (productStr prod)

-- to call orderStr
-- orderStr { id : 1 , product : {name : "Prod", category : "Cat" , price : 10.0}}

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
