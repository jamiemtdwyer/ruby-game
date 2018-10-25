require 'gosu'
require_relative 'config.rb'
require_relative 'bullet.rb'

class Player
  def initialize
    @sprite = Gosu::Image.new("assets/player.png")
    @bullets = []
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @name = "jamie d"
    @label = Gosu::Font.new(12, name: Gosu::default_font_name)
  end

  def shoot
    # find 'tip' of spaceship:
    x = @x + Gosu.offset_x(@angle, @sprite.height / 2)
    y = @y + Gosu.offset_y(@angle, @sprite.height / 2)
    angle = @angle
    bullet = Bullet.new(x, y, angle)

    @bullets << bullet
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
    # offset_x and offset_y compute x and y complements
    @vel_x += Gosu.offset_x(@angle, 0.75)
    @vel_y += Gosu.offset_y(@angle, 0.75)
  end

  def move
    @x = (@x + @vel_x) % Config::WIDTH
    @y = (@y + @vel_y) % Config::HEIGHT
    @vel_x *= 0.98
    @vel_y *= 0.98

    # clean up bullets
    @bullets.reject! { |bullet| not bullet.alive? }
    @bullets.each { |bullet| bullet.move }
  end

  def draw
    @sprite.draw_rot(@x, @y, 1, @angle)
    @label.draw_text(@name, @x - @sprite.height * 0.25, @y - @sprite.height * 0.75, 1, 1.0, 1.0, Gosu::Color::WHITE)

    @bullets.each { |bullet| bullet.draw }
  end
end