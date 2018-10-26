require_relative 'config.rb'

class Bullet
  def initialize(x = 0, y = 0, angle = 0)
    @sprite = Gosu::Image.new("assets/laserRed.png")
    @x = x
    @y = y
    @angle = angle
    @alive = true
  end

  def alive?
    @alive
  end

  def move
    @x += Gosu.offset_x(@angle, 10.0)
    @y += Gosu.offset_y(@angle, 10.0)

    @alive = false if @y > Config::HEIGHT or @y < 0 or @x > Config::WIDTH or @x < 0
  end

  # TODO: Fix "magic" z-number
  def draw
    @sprite.draw_rot(@x, @y, 1, @angle)
  end
end