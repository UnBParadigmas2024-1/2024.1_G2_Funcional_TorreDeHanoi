module Main where

import Dijkstra (dijkstra)

matriz :: [[Int]]
matriz = [[0, 10, 10, 5, 0], [0, 0, 1, 2, 0], [0, 0, 0, 0, 4], [0, 3, 9, 0, 2], [7, 0, 6, 0, 0]]

frutas :: [Int]
frutas = [1, 2, 3]

lengthFrutas :: Int
lengthFrutas = length frutas

main :: IO ()
main = do
  retorno <- dijkstra matriz frutas lengthFrutas
  putStrLn $ "Retorno da função printMatriz: " ++ show retorno



  -- printMatriz :: [[Int]] -> [Int] -> Int -> IO Int
-- printMatriz matriz frutas lengthFrutas = do
--   let frutasPermutations = permutations frutas
--   putStrLn "Frutas Permutations:"
--   print frutasPermutations
--   return 0