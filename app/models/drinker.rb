class Drinker < ActiveRecord::Base

  def to_s
    self.name
    self.message
  end

end
