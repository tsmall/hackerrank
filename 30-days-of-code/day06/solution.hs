import Text.Printf (printf)


main :: IO ()
main = do
  strings <- getInput
  let odds = map oddChars strings
  let evens = map evenChars strings
  mapM_ printResult $ zip odds evens


oddChars :: String -> String
oddChars s =
  case s of
    (odd:even:rest) ->
      let
        remainingOdds = oddChars rest
      in
        odd:remainingOdds
    (odd:_) ->
      [odd]
    [] ->
      []


evenChars :: String -> String
evenChars s =
  case s of
    (odd:even:rest) ->
      let
        remainingEvens = evenChars rest
      in
        even:remainingEvens
    (odd:_) ->
      []
    [] ->
      []


getInput :: IO [String]
getInput = do
  wordCountS <- getLine
  let wordCount = read wordCountS :: Int
  strings <- getMultipleLines wordCount
  return strings


getMultipleLines :: Int -> IO [String]
getMultipleLines n
    | n <= 0 = return []
    | otherwise = do
        x <- getLine
        xs <- getMultipleLines (n-1)
        let ret = (x:xs)
        return ret


printResult :: (String, String) -> IO ()
printResult (oddChars, evenChars) =
  printf "%s %s\n" oddChars evenChars
