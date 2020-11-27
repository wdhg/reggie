{-# OPTIONS_GHC -w #-}
module Parser.Grammer where
import Parser.Tokens
import Program
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4 t5
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,46) ([8800,304,2048,384,8,0,0,24640,34,38912,17416,4096,2048,256,128,3072,0,0,32,16,0,32832,16384,8192,0,0,2,512,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Program","Instruction","register","label","colon","arrow","halt","incr","decr","comma","'\\n'","%eof"]
        bit_start = st * 15
        bit_end = (st + 1) * 15
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..14]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (6) = happyShift action_3
action_0 (7) = happyShift action_4
action_0 (10) = happyShift action_5
action_0 (14) = happyShift action_8
action_0 (4) = happyGoto action_6
action_0 (5) = happyGoto action_7
action_0 _ = happyReduce_4

action_1 (6) = happyShift action_3
action_1 (7) = happyShift action_4
action_1 (10) = happyShift action_5
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (14) = happyShift action_10
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (11) = happyShift action_12
action_3 (12) = happyShift action_13
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (8) = happyShift action_11
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_10

action_6 (15) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (14) = happyShift action_10
action_7 _ = happyReduce_3

action_8 (6) = happyShift action_3
action_8 (7) = happyShift action_4
action_8 (10) = happyShift action_5
action_8 (14) = happyShift action_8
action_8 (4) = happyGoto action_9
action_8 (5) = happyGoto action_7
action_8 _ = happyReduce_4

action_9 _ = happyReduce_2

action_10 (6) = happyShift action_3
action_10 (7) = happyShift action_4
action_10 (10) = happyShift action_5
action_10 (14) = happyShift action_8
action_10 (4) = happyGoto action_18
action_10 (5) = happyGoto action_7
action_10 _ = happyReduce_4

action_11 (6) = happyShift action_16
action_11 (10) = happyShift action_17
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (9) = happyShift action_15
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (9) = happyShift action_14
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (7) = happyShift action_22
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (7) = happyShift action_21
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (11) = happyShift action_19
action_16 (12) = happyShift action_20
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_7

action_18 _ = happyReduce_1

action_19 (9) = happyShift action_25
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (9) = happyShift action_24
action_20 _ = happyFail (happyExpListPerState 20)

action_21 _ = happyReduce_8

action_22 (13) = happyShift action_23
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (7) = happyShift action_28
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (7) = happyShift action_27
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (7) = happyShift action_26
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_5

action_27 (13) = happyShift action_29
action_27 _ = happyFail (happyExpListPerState 27)

action_28 _ = happyReduce_9

action_29 (7) = happyShift action_30
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_6

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 : happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_0  4 happyReduction_4
happyReduction_4  =  HappyAbsSyn4
		 ([]
	)

happyReduce_5 = happyReduce 6 5 happyReduction_5
happyReduction_5 ((HappyTerminal (TokenLabel happy_var_6)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenRegister happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Incr happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 8 5 happyReduction_6
happyReduction_6 ((HappyTerminal (TokenLabel happy_var_8)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLabel happy_var_6)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenRegister happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Decr happy_var_3 (happy_var_6, happy_var_8)
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 _
	_
	_
	 =  HappyAbsSyn5
		 (Halt
	)

happyReduce_8 = happyReduce 4 5 happyReduction_8
happyReduction_8 ((HappyTerminal (TokenLabel happy_var_4)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenRegister happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Incr happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 6 5 happyReduction_9
happyReduction_9 ((HappyTerminal (TokenLabel happy_var_6)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLabel happy_var_4)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenRegister happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Decr happy_var_1 (happy_var_4, happy_var_6)
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_1  5 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn5
		 (Halt
	)

happyNewToken action sts stk [] =
	action 15 15 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenRegister happy_dollar_dollar -> cont 6;
	TokenLabel happy_dollar_dollar -> cont 7;
	TokenColon -> cont 8;
	TokenArrow -> cont 9;
	TokenHalt -> cont 10;
	TokenIncr -> cont 11;
	TokenDecr -> cont 12;
	TokenComma -> cont 13;
	TokenNewLine -> cont 14;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 15 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
