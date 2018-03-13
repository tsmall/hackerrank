import Control.Applicative
import Control.Monad
import System.IO
import Text.Printf


data PointFor
  = Alice
  | Bob
  | Nobody


main :: IO ()
main = do
    a_temp <- getLine
    let as = map read $ words a_temp :: [Int]

    b_temp <- getLine
    let bs = map read $ words b_temp :: [Int]

    let categoryWinners = scoreCategories $ zip as bs
    let (alice, bob) = tallyScores categoryWinners

    printf "%d %d\n" alice bob


tallyScores :: [PointFor] -> (Int, Int)
tallyScores categoryWinners =
  foldl sumScores (0, 0) categoryWinners
  where
    sumScores (a, b) Alice = (a + 1, b)
    sumScores (a, b) Bob = (a, b + 1)
    sumScores (a, b) Nobody = (a, b)


scoreCategories :: [(Int, Int)] -> [PointFor]
scoreCategories categories =
  map score categories
  where
    score (a, b) =
      case (compare a b) of
        GT ->
          Alice
        LT ->
          Bob
        EQ ->
          Nobody
