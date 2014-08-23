-- Paddle Game - #LD30 -- by <weldale@gmail.com>

function love.conf(t)
  t.title = "Paddle Game"
  t.identity = "PaddleGame"
  t.author = "Alexander Weld <weldale@gmail.com>"
  t.modules.physics = false -- don't need that

  t.window.width      = 320
  t.window.height     = 240


  t.console = false
end