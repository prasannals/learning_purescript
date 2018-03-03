```
-- This is a comment in PureScript
-- Comments start with "--"
```


```
module Main where
-- Every file must begin with module declaration.
-- Module name format : One or more capitalized words separated by dots
-- example : "module Blah.SomeOtherBlah.Main"


-- The below statements are all the imports
import Prelude -- this is the PureScript "standard library" kinda thing.
-- Imports a lot of essential stuff
import Control.Monad.Eff (Eff) -- This is... a Monad. Welcome to PureScript.
import Control.Monad.Eff.Console (CONSOLE, log) -- We're importing the "log" function
-- from module "Control.Monad.Eff.Console"

-- this is a function declaration
main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do         -- this is a function definition
  log "Hello sailor!"    -- logging stuff
```
