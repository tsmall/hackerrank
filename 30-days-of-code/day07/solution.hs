main :: IO ()
main = do
  list <- getInput
  printList $ myReverse list


myReverse :: [a] -> [a]
myReverse list =
  case list of
    [] ->
      []
    xs ->
      last xs : myReverse (init xs)


getInput :: IO [Int]
getInput = do
  n_temp <- getLine
  let n = read n_temp :: Int
  lst_temp <- getLine
  let lst = map read $ words lst_temp :: [Int]
  return lst


printList :: Show a => [a] -> IO ()
printList list =
  putStrLn $ unwords $ map show list
