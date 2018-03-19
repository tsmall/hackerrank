data BillInfo = BillInfo
  { skippedItemIndex :: Int
  , itemCosts :: [Int]
  , chargedAmount :: Int
  } deriving (Show)


main :: IO ()
main = do
  billInfo <- parseInput
  printResult $ calculateDifference billInfo


calculateDifference :: BillInfo -> Int
calculateDifference bill =
  (chargedAmount bill) - expectedAmount
  where
    expectedAmount = (sum splitItems) `div` 2
    splitItems = dropAt (skippedItemIndex bill) (itemCosts bill)


dropAt :: Int -> [a] -> [a]
dropAt n xs =
  before ++ after
  where
    (before, (_:after)) = splitAt n xs


parseInput :: IO BillInfo
parseInput = do
  [_, skippedItemIndex] <- parseLine
  itemCosts <- parseLine
  [chargedAmount] <- parseLine
  return BillInfo
    { skippedItemIndex = skippedItemIndex
    , itemCosts = itemCosts
    , chargedAmount = chargedAmount
    }


parseLine :: IO [Int]
parseLine = do
  line <- getLine
  return $ map read $ words line


printResult :: Int -> IO ()
printResult 0 =
  putStrLn "Bon Appetit"
printResult difference =
  putStrLn $ show difference
