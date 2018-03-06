module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

type Product = {name :: String, category :: String, price :: Number}
type Order = {id :: Int, product :: Product}

orderStr :: Order -> String
orderStr order = (show order.id) <> ", " <> (productStr order.product)

productStr :: Product -> String
productStr product = product.name <> " : " <> product.category <> " : " <> (show $ product.price)

myProduct :: Product
myProduct = {name : "Galaxy S9", category : "SmartPhones", price : 60000.0}

myOrder :: Order
myOrder = {id : 1, product : myProduct}

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = log (orderStr myOrder)
