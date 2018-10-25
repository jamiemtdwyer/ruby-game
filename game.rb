require 'gosu'
require_relative 'config.rb'
require_relative 'player.rb'

class Game < Gosu::Window
  def initialize
    super Config::WIDTH, Config::HEIGHT
    self.caption = "Space shooter"

    @background_image = Gosu::Image.new("assets/space.png", tileable: true)

    @player = Player.new
    @player.warp(Config::WIDTH / 2, Config::HEIGHT / 2)
  end

  def update
    handle_input

    @player.move
  end

  def handle_input
    @player.turn_left if Gosu.button_down? Gosu::KB_LEFT
    @player.turn_right if Gosu.button_down? Gosu::KB_RIGHT
    @player.accelerate if Gosu.button_down? Gosu::KB_UP
    @player.shoot if Gosu.button_down? Gosu::KB_SPACE

    close if Gosu.button_down? Gosu::KB_ESCAPE
  end

  def draw
    @player.draw
    @background_image.draw(0, 0, 0)
  end
end

Game.new.show