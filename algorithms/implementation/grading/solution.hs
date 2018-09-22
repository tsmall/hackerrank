module Main where

type Grade = Int

main :: IO ()
main = do
  grades <- parseGrades
  printGrades $ roundGrades grades


passingGrade :: Grade
passingGrade =
  40


roundGrades :: [Grade] -> [Grade]
roundGrades grades =
  map roundGrade grades


roundGrade :: Grade -> Grade
roundGrade grade =
  if possibleCloseEnough && possible >= passingGrade
  then
    possible
  else
    grade
  where
    possible =
      nextDivisibleNum 5 grade
    possibleCloseEnough =
      possible - grade < 3


nextDivisibleNum :: Int -> Int -> Int
nextDivisibleNum divisor num =
  case num `mod` divisor of
    0 ->
      num
    _ ->
      nextDivisibleNum divisor (num + 1)


parseGrades :: IO [Grade]
parseGrades = do
  n_temp <- getLine
  let n = read n_temp :: Int
  parseGradeLines n []


parseGradeLines :: Int -> [Grade] -> IO [Grade]
parseGradeLines 0 grades =
  return $ reverse grades
parseGradeLines n grades = do
  line <- getLine
  let grade = read line :: Int
  parseGradeLines (n - 1) (grade : grades)


printGrades :: [Grade] -> IO ()
printGrades grades = do
  mapM_ putStrLn $ map show grades
