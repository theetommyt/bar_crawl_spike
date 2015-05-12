namespace :db do
  desc 'Calculate all the distances'
  task :distances => :environment do

    puts 'CALCULATING DISTANCES'
    puts '.....................'

    BarDistance.delete_all

    def power(num, pow)
      num ** pow
    end


    def haversine(lat1, long1, lat2, long2)
      dtor = Math::PI/180
      r = 3959

      rlat1 = lat1 * dtor
      rlong1 = long1 * dtor
      rlat2 = lat2 * dtor
      rlong2 = long2 * dtor

      dlon = rlong1 - rlong2
      dlat = rlat1 - rlat2

      a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      d = r * c

      return d
    end

    # def pythagorean(lat1, long1, lat2, long2)
    #   a = (lat1 - lat2).abs
    #   b = (long1 - long2).abs
    #   Math::sqrt((a**2) + (b**2))
    # end


    bars = Bar.all

    bars.map do |a| # Grab a bar!

      puts a ## I want to see the progress

      individual_bar_distances = bars.map do |b| # For ALL other bars
        if a.id != b.id  # As long as it's not the same bar

          distance = haversine(a.lat, a.long, b.lat, b.long) # Compute the distance

          if distance>0 && distance < 3 # As long as the distance is real....
            {
              start_bar_id: a.id,
              end_bar_id: b.id,
              distance: distance
            }
          end
        end
      end
      if individual_bar_distances.length > 0
        BarDistance.create(individual_bar_distances.flatten)  # Put them in the database
      end

    end #  bars.map do |a|



  end
end
