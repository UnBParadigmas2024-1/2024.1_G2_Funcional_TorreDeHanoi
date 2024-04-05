import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Interact (Event)
import Graphics.Gloss.Interface.IO.Game (Event(..), KeyState(..), Key(..))
import Map (mazeMap, Cell(..))
import Maze (Maze, generateLeaves, updateMaze)


cellSize :: Float
cellSize = 20

cellToPicture :: Cell -> Picture
cellToPicture Wall = color black $ rectangleSolid cellSize cellSize
cellToPicture Path = color white $ rectangleSolid cellSize cellSize
cellToPicture Start = color green $ rectangleSolid cellSize cellSize
cellToPicture End = color red $ rectangleSolid cellSize cellSize
cellToPicture Leaf = color orange $ rectangleSolid cellSize cellSize

sampleWorld :: Maze -> World
sampleWorld maze = World {worldMap = maze}

data World = World {worldMap :: Maze}

mazeToPicture :: World -> Picture
mazeToPicture world =
  let maze = worldMap world
      reversedMaze = reverse maze
   in translate (-240) (-225) . pictures $
        [ translate (x * cellSize) (y * cellSize) (cellToPicture cell)
        | (y, row) <- zip [0 ..] reversedMaze
        , (x, cell) <- zip [0 ..] row
        ]

handleInput :: Event -> World -> World
handleInput (EventKey (Char 'r') Down _ _) world = sampleWorld mazeMap
handleInput _ world = world

handleInput :: Event -> World -> World
handleInput (EventKey (Char 'r') Down _ _) world = do
    putStrLn "Restarting..."
    -- Lógica de reinício do jogo
    return world  -- ou return novoEstadoDoMundo, dependendo da lógica do jogo
handleInput _ world = return world


main :: IO ()
main = do
  let initialMaze = mazeMap
  leaves <- generateLeaves initialMaze
  let mazeWithLeaves = foldl (\mz (x, y) -> updateMaze mz (x, y) Leaf) initialMaze leaves
  play
    (InWindow "Belesminha" (600, 600) (0, 0))
    white
    30
    (sampleWorld mazeWithLeaves)
    mazeToPicture
    handleInput
    (\_ world -> world)  -- Função de renderização de eventos
