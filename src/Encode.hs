{-# LANGUAGE FlexibleInstances #-}

module Encode where

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
