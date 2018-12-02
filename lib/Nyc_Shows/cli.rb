class NycShows::CLI
  #fix video and send link to video and get it working
  
  def call
    NycShows::Scraper.make_shows
    puts "Hello!"
    command
  end
  
  def command
    puts "What would you like to do?"
    puts "Type 'shows' for a list of all show names."
    puts "Type 'broadway' for all broadway shows."
    puts "Type 'off-broadway' for all off-broadway shows."
    puts "Type 'story' if you would like to know a play's plot."
    puts "Type 'exit' if you're done for the day."
   input = gets.strip.downcase
      if input == "shows"
        all_shows
      elsif input == "broadway" || input == "off-broadway"
        show_type(input)
      elsif input == "story"
        show_story
      elsif input == "exit"
        puts "See you next time!"
      else
        puts "Please enter a valid command"
        command
      end
    end

    def all_shows
      @shows = NycShows::Show.all
      @shows = @shows.sort {|x,y| x.name <=> y.name}
      @shows.each_with_index do |show, index|
        puts "#{index+1}. #{show.name.capitalize} - Theater: #{show.location.capitalize} - Show length: #{show.duration} - Genre: #{show.genre.capitalize}"
      end
      command
    end
    
    def show_type(input)
      @shows = NycShows::Show.all
      found_shows = @shows.map do |show|
        if show.genre == input
          show
        end
      end
      sorted = found_shows.sort {|x,y| x.name <=> y.name}
      sorted.each_with_index do |show, index|
        puts "#{index+1}. #{show.name.capitalize}"
      end
      command
    end

    def show_story
      @show = NycShows::Show
      puts "Please enter the name of a show or type 'exit' to return to main menu:"
      s = gets.downcase
      show = @show.find_by_name(s)
      if show != nil
        puts "#{show.name.capitalize} - #{show.story}"
        show_story
      elsif show == nil
        puts "Sorry, that's not a current show. Please try again."
        show_story
      end
      if s == "exit"
        command
      end
    end
    
end