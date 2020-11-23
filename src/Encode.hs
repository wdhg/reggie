{-# LANGUAGE FlexibleInstances #-}

module Encode where

import Program (Instruction(..))

class Encode a where
 -- Bijection from NxN to N+
  encode :: Integral b => a -> b

  -- Bijection from NxN to N
  encode' :: Integral b => a -> b
  encode' = pred . encode

instance (Integral a, Integral b) => Encode (a, b) where
 encode (x, y)
   = fromIntegral $ (2 ^ x) * (2 * y + 1)

instance Encode a => Encode [a] where
  encode
    = foldr (\x y -> encode (encode x, y)) 0

instance Encode Instruction where
  encode (Incr reg next)
    = encode (2 * reg, next)
  encode (Decr reg nexts)
    = encode (2 * reg + 1, encode' nexts)
  encode Halt
    = 0
