require_relative 'config.rb'

class Powerup
  attr_reader :x, :y

  def initialize(x: 0, y: 0)
    @sprite = Gosu::Image.new("assets/star_gold.png")
    @x = x
    @y = y
  end

  # TODO: Fix "magic" z-number
  def draw
    @sprite.draw_rot(x, y, 1, 0)
  end
end