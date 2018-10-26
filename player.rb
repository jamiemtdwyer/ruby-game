require 'gosu'
require_relative 'config.rb'
require_relative 'bullet.rb'

class Player
  FIRE_DELAY = 100

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @vel_x = @vel_y = @angle = 0.0
    @name = "jamie d"
    @last_fired = 0
    @bullets = []

    @sprite = Gosu::Image.new("assets/player.png")
    @label = Gosu::Font.new(12, name: Gosu::default_font_name)
  end

  def shoot
    if (Gosu.milliseconds - @last_fired) > FIRE_DELAY
      bullet = Bullet.new(
        @x + Gosu.offset_x(@angle, @sprite.height / 2),
        @y + Gosu.offset_y(@angle, @sprite.height / 2),
        @angle
      )

      @bullets << bullet
      @last_fired = Gosu.milliseconds
    end
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.25)
    @vel_y += Gosu.offset_y(@angle, 0.25)
  end

  def update
    @x = (@x + @vel_x) % Config::WIDTH
    @y = (@y + @vel_y) % Config::HEIGHT
    @vel_x *= 0.98
    @vel_y *= 0.98

    @bullets.reject! { |bullet| not bullet.alive? }
    @bullets.each { |bullet| bullet.update }
  end

  # TODO: Fix "magic" z-number
  def draw
    @sprite.draw_rot(@x, @y, 1, @angle)
    @label.draw_text(@name, @x - @sprite.height * 0.25, @y - @sprite.height * 0.75, 1, 1.0, 1.0, Gosu::Color::WHITE)

    @bullets.each { |bullet| bullet.draw }
  end
end