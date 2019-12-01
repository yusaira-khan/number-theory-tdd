module Sparse.HelperSpec(spec) where
import Test.Hspec
import Sparse.Helper as SH
checkAsBig :: (String,(Bool,Int),Int,(Bool,Int)) -> SpecWith ()
checkAsBig (s,t1,n,t2)= it s $ (SH.asBigAs t1 n) `shouldBe` t2
asBigAsTest  :: Spec
asBigAsTest  = describe "as big as" $ do
  checkAsBig ("simplest",(True, 0),1,(True,1))
  checkAsBig ("False",(False, 1),2,(False,1))
  checkAsBig ("Less2",(True, 1),2,(True,2))
  checkAsBig ("Less4",(True, 1),4,(True,4))
  checkAsBig ("Equal",(True, 1),1,(False,1))
  checkAsBig ("Greater",(True, 2),1,(False,2))

spec = do
  asBigAsTest
