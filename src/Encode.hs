{-# LANGUAGE FlexibleInstances #-}

module Encode where

import Program (Instruction(..), Program(..), Label(..))
import Data.List (unfoldr)
import Data.Map (toAscList, fromList)

class Encode a where
 -- Bijection from NxN to N+
  encode :: Integral b => a -> b

  decode :: Integral b => b -> a

  -- Bijection from NxN to N
  encode' :: Integral b => a -> b
  encode' = pred . encode

  decode' :: Integral b => b -> a
  decode' = decode . succ

logBaseIntegral :: Integral a => a -> a -> a
logBaseIntegral base x
  | x <= 1    = 0
  | otherwise = 1 + logBaseIntegral base (x `div` base)

instance (Integral a, Integral b) => Encode (a, b) where
  encode (x, y)
    = fromIntegral $ (2 ^ x) * (2 * y + 1)

  decode z
    = let q = until odd (`div` 2) z
          y = fromIntegral $ (q - 1) `div` 2
          x = fromIntegral $ logBaseIntegral 2 (z `div` q)
       in (x, y)

instance Encode a => Encode [a] where
  encode
    = foldr (\x y -> encode (encode x, y)) 0

  decode z
    = let f 0 = Nothing
          f a = let (x, y) = decode a
                 in Just (decode x, y)
       in unfoldr f z

instance Encode Instruction where
  encode (Incr reg (Label next))
    = encode (2 * reg, next)
  encode (Decr reg (Label nextThen, Label nextElse))
    = encode (2 * reg + 1, encode' (nextThen, nextElse))
  encode Halt
    = 0

  decode 0
    = Halt
  decode x
     = let (y,z) = decode x
           i = y `div` 2
           (j,k) = decode' z
        in if even y
              then Incr i (Label z)
              else Decr i (Label j, Label k)

instance Encode Program where
  encode (Program instrs)
    = encode $ padMissing (Label 0) $ toAscList instrs
      where
        padMissing :: Label -> [(Label, Instruction)] -> [Instruction]
        padMissing _ []
          = []
        padMissing label pairs@((label', instr) : remaining)
          | label < label' = Halt : padMissing (succ label) pairs
          | otherwise      = instr : padMissing (succ label') remaining

  decode x
    | x < 0     = error "negative encoding"
    | otherwise = Program $ fromList $ zipWith (\l i -> (Label l, i)) [0..] $ decode x
