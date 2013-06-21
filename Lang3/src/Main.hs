--import Debug.Trace (trace)
trace _ = id

data Term = TTrue | TFalse | Zero
          | Succ Term | Pred Term | IsZero Term
          | If Term Term Term
            deriving (Eq, Show)

data EvalTerm = ETrue | EFalse | EZero
              | ESucc (Do EvalTerm) | EPred (Do EvalTerm) | EIsZero (Do EvalTerm)
              | EIf (Do EvalTerm) (Do EvalTerm) (Do EvalTerm)
                deriving (Eq, Show)

data Do t = Done t
          | NotYet t

evaluate :: Term -> Term
evaluate = undefined

eval :: Do EvalTerm -> Do EvalTerm
eval (NotYet (EIsZero t)) =
    case eval t of
        (

{-
eval (IsZero Zero)       = trace "IsZero Zero" $ TTrue
eval (IsZero TTrue)      = trace "IsZero TTrue" $ TFalse
eval (IsZero TFalse)     = trace "IsZero TFalse" $ TFalse
eval (IsZero t)          = trace "IsZero t" $ isZero $ eval t
    where
        isZero Zero = TTrue
        isZero _    = TFalse
eval (If c t f)          = trace "If t t t" $ if eval c == TTrue then eval t else eval f
eval (Succ (Pred t))     = trace "Succ (Pred t)" $ eval t
eval (Succ t@(If _ _ _)) = trace "Succ (If c t f)" $ eval $ Succ $ eval t
eval (Succ t)            = trace "Succ t" $ Succ $ eval t
eval (Pred (Succ t))     = trace "Pred (Succ t)" $ eval t
eval (Pred t@(If _ _ _)) = trace "Succ (If c t f)" $ eval $ Pred $ eval t
eval (Pred t)            = trace "Pred t" $ Pred $ eval t
eval t                   = trace "t" $ t
-}
pretty :: Term -> String
pretty TTrue  = "True"
pretty TFalse = "False"
pretty t      = show $ num t

num :: Term -> Integer
num (Succ t) = (num t) + 1
num (Pred t) = (num t) - 1
num Zero     = 0
num _        = error "not evaluated syntax tree"

main = do
    putStrLn $ pretty $ evaluate $ Succ $ Zero
    putStrLn $ pretty $ evaluate $
            If (IsZero $ Pred $ Succ $ Zero)
               (Succ $ Succ $ Succ $ Zero)
               (Pred $ Zero)
    putStrLn $ pretty $ evaluate $
            IsZero (Pred (If TTrue (Succ Zero) Zero))
