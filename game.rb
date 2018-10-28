require 'gosu'
require_relative 'config.rb'
require_relative 'player.rb'
require_relative 'powerup.rb'

class Game < Gosu::Window
  def initialize
    super Config::WIDTH, Config::HEIGHT
    self.caption = "Space shooter"

    @background_image = Gosu::Image.new("assets/space.png", tileable: true)

    @player = Ship.new(
      x: Config::WIDTH / 2,
      y: Config::HEIGHT / 2,
      sprite: "assets/player.png",
      name: "jamie d")

    @enemy = Ship.new(
      x: rand(Config::WIDTH),
      y: rand(Config::HEIGHT),
      sprite: "assets/enemy.png",
      name: "bad guy")

    @powerups = []
  end

  def update
    spawn_powerups

    handle_input

    @player.update
    check_collisions
  end

  # TODO: Fix "magic" z-number for background image
  def draw
    @background_image.draw(0, 0, 0)
    @player.draw
    @enemy.draw
    @powerups.each { |p| p.draw }
  end

  private

  def handle_input
    @player.turn_left if Gosu.button_down?(Gosu::KB_LEFT)
    @player.turn_right if Gosu.button_down?(Gosu::KB_RIGHT)
    @player.accelerate if Gosu.button_down?(Gosu::KB_UP)
    @player.shoot if Gosu.button_down?(Gosu::KB_SPACE)

    close if Gosu.button_down?(Gosu::KB_ESCAPE)
  end

  def check_collisions
    @player.collect_powerups(@powerups)

    @player.bullets.each do |bullet|
      if Gosu.distance(bullet.x, bullet.y, @enemy.x, @enemy.y) < 50
        @enemy.die
        bullet.die
      end
    end
  end

  def spawn_powerups
    # 0.1% chance of a powerup spawning every "tick"
    # maximum of 5 powerups on the board
    if rand(1000) < 1 && @powerups.size < 5
      @powerups << Powerup.new(x: rand(Config::WIDTH), y: rand(Config::HEIGHT))
    end
  end

end

Game.new.show