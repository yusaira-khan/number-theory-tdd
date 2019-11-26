--{-# LANGUAGE InstanceSigs #-}
module Sparse.Binary(SBinary(SBinary),toEnum') where
import Sparse.Helper as H

largestPow2SoFar :: Int -> Int
largestPow2SoFar = H.largestPowBaseBetween 2 1

toEnum' :: Int -> [Int]
toEnum' 0 = []
toEnum' num =
  let pow2 = largestPow2SoFar num
      rest = num `rem` pow2
  in if num > pow2
    then toEnum' rest++[pow2]
    else [num] -- num == pow2

fromEnum' :: [Int] -> Int
fromEnum' = sum
show' :: (Enum a)=>(a->[Int]) -> (a->String) -> a -> String
show' sparseFun binaryReprFun sb =
 let listStr = show $sparseFun sb
     decStr = show $fromEnum sb
     fullBaseStr = binaryReprFun sb
 in "(S="++listStr++"|D="++decStr++"|B="++fullBaseStr++")"

newtype SBinary = SBinary {sBinary :: [Int]}

binaryRepr :: [Int] -> String
binaryRepr [] = "0"
binaryRepr [1]= "1"
binaryRepr (num:rest)=if (num>=2) then"1"++(binaryRepr rest) else undefined
--todo: 2 ideas:
-- with reverse, have a left number, when 4, left =3, decrement left with each digit added
--without reverse, add number least to most significant, but have a pow2 multiplier. if pow2 present then add 1,else 0
showBinaryWBase :: SBinary -> String
showBinaryWBase sb =
  let baseStr = "2"
      sl = reverse $ sBinary sb
  in baseStr++"_"++ (binaryRepr sl)

instance Show SBinary where
  show = show' sBinary showBinaryWBase
instance Enum SBinary where
  toEnum d = SBinary $ toEnum' d
  fromEnum sb = fromEnum' $ sBinary sb
