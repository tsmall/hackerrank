main :: IO ()
main = do
  n <- getInput
  printResult $ factorial n


factorial :: Int -> Int
factorial 1 = 1
factorial n = n * factorial (n - 1)


getInput :: IO Int
getInput = do
  n_temp <- getLine
  let n = read n_temp :: Int
  return n


printResult :: Int -> IO ()
printResult factorial =
  putStrLn $ show factorial
