module Main where

import System.IO (hFlush, stdout)

data State = On | Off deriving (Show, Eq)

toggle :: State -> State
toggle On  = Off
toggle Off = On

prompt :: IO String
prompt = do
  putStr "Enter command (toggle, status, exit): "
  hFlush stdout
  getLine

loop :: State -> IO ()
loop state = do
  cmd <- prompt
  case cmd of
    "toggle" -> do
      let newState = toggle state
      putStrLn $ "State is now: " ++ show newState
      loop newState
    "status" -> do
      putStrLn $ "Current state: " ++ show state
      loop state
    "exit" -> putStrLn "Goodbye!"
    _ -> do
      putStrLn "Unrecognized command."
      loop state

main :: IO ()
main = do
  putStrLn "Toggle App (type 'toggle', 'status', or 'exit')"
  loop Off
