module Encode where

-- Bijection from NxN to N+
encode :: (Int, Int) -> Int
encode (x, y)
  = (2 ^ x) * (2 * y + 1)

-- Bijection from NxN to N
encode' :: (Int, Int) -> Int
encode'
  = pred . encode
