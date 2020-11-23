{-# LANGUAGE FlexibleInstances #-}

module Encode where

class Encode a where
 -- Bijection from NxN to N+
  encode :: Integral b => a -> b

  -- Bijection from NxN to N
  encode' :: Integral b => a -> b
  encode' = pred . encode

instance Integral a => Encode (a, a) where
 encode (x, y)
   = fromIntegral $ (2 ^ x) * (2 * y + 1)
