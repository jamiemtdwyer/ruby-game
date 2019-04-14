require_relative 'config.rb'

class Bullet
  attr_reader :x, :y

  ACCELERATION = 10.0

  def initialize(x: 0, y: 0, angle: 0)
    @sprite = Gosu::Image.new("assets/laserRed.png")
    @x = x
    @y = y
    @angle = angle
    @alive = true
  end

  def alive?
    @alive
  end

  def die
    @alive = false
  end

  def update
    @x += Gosu.offset_x(@angle, ACCELERATION)
    @y += Gosu.offset_y(@angle, ACCELERATION)

    self.die if @y > Config::HEIGHT or @y < 0 or @x > Config::WIDTH or @x < 0
  end

  def draw
    @sprite.draw_rot(@x, @y, Config::Z_SPRITE, @angle)
  end
end
