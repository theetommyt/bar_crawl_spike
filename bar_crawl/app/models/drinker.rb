class Drinker < ActiveRecord::Base

  def to_s
    self.message
  end

end
