module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.String (length)

foreign import addAwesome :: String -> String
foreign import fakeAwesome :: String -> String
foreign import someCalc :: Number -> Number
foreign import logIt :: forall eff. String -> Eff (console :: CONSOLE | eff) Unit

foreign import data MyNewData :: Type -> Type

foreign import jsCalc :: forall a. a -> MyNewData a
foreign import getName :: forall a. MyNewData a -> a
foreign import getPlace :: forall a. MyNewData a -> a

fakeAwesomeTest :: forall e. String -> Eff (console :: CONSOLE | e) Unit
fakeAwesomeTest st = log $ ( "fakeAwesome output : " <> (fakeAwesome st))

fakeAwesomeCrash :: forall e. String -> Eff (console :: CONSOLE | e) Unit
fakeAwesomeCrash st = log $ show $ length (fakeAwesome st)

someCalcTest :: forall e. Number -> Eff (console :: CONSOLE | e) Unit
someCalcTest param = log $ show $ (someCalc param )


myNewDataTest :: forall e. MyNewData String -> Eff (console :: CONSOLE | e) Unit
myNewDataTest dat = log $ getPlace dat


data Account a = SBAccount a | LoanAccount a | BusinessAccount a

foreign import processAccount :: forall a. (Account a) -> Boolean

accountTest :: forall a e. a -> Eff (console :: CONSOLE | e) Unit
accountTest aData = log $ "Account returns : " <> (show $ processAccount (SBAccount aData))

foreign import data Contacts :: Type
foreign import createNewContacts :: Contacts
foreign import addToContacts :: Contacts -> String -> String -> Contacts
foreign import updateContacts :: Contacts -> String -> String -> Contacts
foreign import removeFromContacts :: Contacts -> String -> Contacts
foreign import contactsStr :: Contacts -> String

addTest :: Contacts
addTest = addToContacts (addToContacts (createNewContacts) "Prasanna" "1234") "Person2" "5678"

updateTest :: Contacts
updateTest = updateContacts addTest "Prasanna" "9876"

removeTest :: Contacts
removeTest = removeFromContacts addTest "Prasanna"

contactsTest :: forall e. Eff (console :: CONSOLE | e) Unit
contactsTest = log $ contactsStr $ removeTest

main :: Eff (console :: CONSOLE) Unit
main = logIt $ "Hello, Sailorrrr"
