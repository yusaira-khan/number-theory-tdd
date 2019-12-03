module Sparse.TernarySpec (spec) where
import Test.Hspec
import qualified Sparse.Ternary as ST
import qualified Helper as H

testList = [
      ("One" , 1 , [1]),
      ("Two" , 2 , [2]),
      ("Three" , 3 , [3]),
      ("Four" , 4 , [1,3]),
      ("Five" , 5 , [2,3]),
      ("Six" , 6 , [6]),
      ("Seven" , 7 , [1,6]),
      ("Eight" , 8 , [2,6]),
      ("Nine" , 9 , [9]),
      ("Ten" , 10 , [1,9]),
      ("Eleven" , 11 , [2,9]),
      ("Twelve" , 12 , [3,9]),
      ("Zero" , 0 , [])]
toEnumFun :: (String,Int,[Int]) -> SpecWith ()
toEnumFun = H.testToEnum ST.toEnum'

toEnum'' :: Spec
toEnum'' = H.testGen toEnumFun "Sparse Ternary ToEnum" testList

checkStr ::(String,Int,String) -> SpecWith ()
checkStr  = H.checkStrReprFun (show . ST.STernary . ST.toEnum')
stringtest :: Spec
stringtest = describe "Sparse Ternary String" $ do
  checkStr("Zero",0,"(S=[]|D=0|B=3_0)")
  checkStr("One",1,"(S=[1]|D=1|B=3_1)")
  checkStr("Two",2,"(S=[2]|D=2|B=3_2)")
  checkStr("Three",3,"(S=[3]|D=3|B=3_10)")
  checkStr("Four",4,"(S=[1,3]|D=4|B=3_11)")
  checkStr("Five",5,"(S=[2,3]|D=5|B=3_12)")
  checkStr("Six",6,"(S=[6]|D=6|B=3_20)")
st a = toEnum a :: ST.STernary
checkSucc :: (String,Int)->SpecWith ()
checkSucc = H.checkSucc st

testSucc :: Spec
testSucc = describe "Ternary Succ test" $ do
  checkSucc ("Zero",0)
spec = do
  toEnum''
  stringtest
  testSucc
