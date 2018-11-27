class NycShows::CLI
  
  def call
    puts "Hello! What would you like to do?"
    puts "Type 'shows' for a list of all show names."
    puts "Type 'broadway' for all broadway shows."
    puts "Type 'off-broadway' for all off-broadway shows."
    puts "Type 'story' if you would like to know a play's plot."
    puts "Type 'exit' if you're done for the day."
    
    input = gets.strip.downcase
      if input == "shows"
        all_shows
       elsif input == "broadway" || input == "off"
        show_type(input)
      elsif input == "story"
        show_story
      elsif input == "exit"
        puts "See you next time!"
      else
        puts "Please enter a valid command"
        command
      end
    NycShows::Scraper.new.make_shows
    end

    def all_shows
      @shows = NycShows::Show.all
      @shows = @shows.sort {|x,y| x.name <=> y.name}
      @shows.each_with_index do |show, index|
        puts "#{index+1}. #{show.name.titleize} - where: #{show.location} - length: #{show.duration} - genre: #{show.genre}"
      end
    end
    
    def show_type(input)
      b_shows = []
      @shows.each do |show|
        if show.genre == input
          b_shows << show
        end
      end
      b_shows.sort {|x,y| x.name <=> y.name}
      b_list = b_shows.each_with_index(1) do |show, index|
        puts "#{index}. #{show.name.titleize}"
      end
      b_list
      command
    end

    def show_story
      puts "Please enter the name of a show or type 'exit' to return to main menu:"
      s = gets.strip.downcase
      show = @show.find_by_name(s)
      if show != nil
        puts "#{show.name.titleize} - #{show.story}"
        show_story
      elsif show == nil
        puts "Sorry, that's not a current show. Please try again."
        show_story
      end
      if s == 'exit'
        command
      end
    end
    
end