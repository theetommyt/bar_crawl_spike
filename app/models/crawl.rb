class Crawl < ActiveRecord::Base

  # Adds a bar to the crawl
  def add_bar!(bar)
    self.bars << bar.id
    self.save
  end

  # def self.generate(lat, long, num_stops)
  #   crawl = self.new
  #   num_stops.times.map do |i|
  #     bar = Bar.search_bars(lat, long, 15)[i]
  #     lat = bar.lat
  #     long = bar.long
  #     crawl.add_bar(bar)
  #   end
  #   crawl.save
  # end
  #


  def self.choose_own_disaster(crawl, num_stops)

    if crawl.bars.length < num_stops
      # Set up the two crawl options
      left_crawl = crawl # One choice
      right_crawl = self.create({
        bars: left_crawl.bars,
        name: left_crawl.name
      }) # Second choice

      last_bar = Bar.find(left_crawl.bars.last)
      bar_options = Bar.search_bars(last_bar.lat, last_bar.long, 15)

      cleaned_bar_options = []
      in_crawl_ids = left_crawl.bars
      bar_options.each do |bar|
        unless in_crawl_ids.include?(bar.id)
          cleaned_bar_options.push(bar)
        end
      end

      left_crawl.add_bar!(cleaned_bar_options[0])
      right_crawl.add_bar!(cleaned_bar_options[1])
      self.choose_own_disaster(left_crawl, num_stops)
      self.choose_own_disaster(right_crawl, num_stops)
    end
  end

  def self.brackets(name, lat, long, num_stops)
    crawl = self.create({name: name})
    bar = Bar.search_bars(lat,long, 1)[0]
    crawl.add_bar!(bar)
    self.choose_own_disaster(crawl, num_stops)
    self.where(name: name)
  end

  # Crawl.brackets('Joeys', 41.88990488, -87.63122455, 3)

end
