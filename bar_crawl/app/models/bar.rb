class Bar < ActiveRecord::Base

  def to_s
    self.message
  end

end
