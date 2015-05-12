class Bar < ActiveRecord::Base

  has_many :bar_distances, foreign_key: :start_bar_id

  def closest_bars(num_bars=1)
    self.bar_distances.order(:distance).slice(0..(num_bars-1))
  end


  def to_s
    self.name
  end

end



# class Farmer < ActiveRecord::Base
#   has_many :cows, foreign_key: :farmer_id
# end
# Assume a cows includes a farmer_id
