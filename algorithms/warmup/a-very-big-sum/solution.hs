module Main where

main :: IO ()
main = do
    array <- getInput
    let result = sum array
    printResult result

getInput :: IO [Int]
getInput = do
    countLine <- getLine
    arrayLine <- getLine
    let numbers = map read $ words arrayLine
    return numbers

printResult :: Int -> IO ()
printResult =
    putStrLn . show
