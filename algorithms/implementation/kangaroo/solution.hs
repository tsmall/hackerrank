import Control.Applicative
import Control.Monad
import System.IO


data Vector = Vector
  { position :: Int
  , velocity :: Int
  } deriving (Show)


main :: IO ()
main = do
  [v1, v2] <- getInput
  putStrLn $ yesNo $ willMeet v1 v2


getInput :: IO [Vector]
getInput = do
  line <- getLine
  let ns = map read $ words line :: [Int]
  let [x1, v1, x2, v2] = ns
  return
    [ Vector {position=x1, velocity=v1}
    , Vector {position=x2, velocity=v2}
    ]


yesNo :: Bool -> String
yesNo True = "YES"
yesNo False = "NO"


willMeet :: Vector -> Vector -> Bool
willMeet v1 v2
  | position v1 == position v2 = True
  | otherwise =
      canCatchUp back front && pathsCrossAtSamePoint back front
      where
        [back, front] = order v1 v2


order :: Vector -> Vector -> [Vector]
order v1 v2 =
  case compare (position v1) (position v2) of
    LT -> [v1, v2]
    GT -> [v2, v1]
    EQ -> [v1, v2]


canCatchUp :: Vector -> Vector -> Bool
canCatchUp back front =
  velocity back > velocity front


pathsCrossAtSamePoint :: Vector -> Vector -> Bool
pathsCrossAtSamePoint back front =
  position back' == position front'
  where
    [back', front'] = moveUntilCrossed back front


moveUntilCrossed :: Vector -> Vector -> [Vector]
moveUntilCrossed back front =
  case position back < position front of
    True ->
      moveUntilCrossed
        back {position = (position back) + (velocity back)}
        front {position = (position front) + (velocity front)}
    False ->
      [back, front]
