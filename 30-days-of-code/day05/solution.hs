import Control.Applicative
import Control.Monad
import System.IO
import Text.Printf


main :: IO ()
main = do
  n <- getInput
  mapM_ printMultiple $ take 10 $ multiplesOf n 1


getInput :: IO Int
getInput = do
  n_temp <- getLine
  let n = read n_temp :: Int
  return n


multiplesOf :: Int -> Int -> [(Int, Int, Int)]
multiplesOf n multiple =
  let result = n * multiple in
    (n, multiple, result) : multiplesOf n (succ multiple)


printMultiple :: (Int, Int, Int) -> IO ()
printMultiple (n, multiple, result) =
  printf "%d x %d = %d\n" n multiple result
