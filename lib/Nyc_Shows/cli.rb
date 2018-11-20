

class NycShows::CLI
  
  def command
    puts "Hello! What would you like to do?"
    puts "Type 'shows' for a list of all show names."
    puts "Type 'broadway' for all broadway shows."
    puts "Type 'off-broadway' for all off-broadway shows."
    puts "Type 'show story' if you would like to know a play's plot."
    puts "Type 'exit' if you're done for the day."
    input = gets.strip.downcase
      if input == "all shows"
        all_shows
       elsif input == "broadway"
        broadway
      elsif input == "off-broadway"
        off_broadway
      elsif input == "show story"
        show_story
      elsif input == "exit"
        puts "See you next time!"
      else
        puts "Please enter a valid command"
        call
      end
    end

    def all_shows
      shows = Shows.all.sort {|x,y| x.name <=> y.name}
      show_list = shows.each_with_index do |show, index|
        puts "#{index+1}. #{show.name.titleize} - where: #{show.location} - length: #{show.duration} - genre: #{show.genre}"
      end
      show_list
    end
    
    def broadway
      b_shows = []
      Shows.all.each do |show|
        if show.genre == "broadway"
          b_shows << show
        end
      end
      b_shows.sort {|x,y| x.name <=> y.name}
      b_list = b_shows.each_with_index do |show, index|
        puts "#{index+1}. #{show.name.titleize}"
      end
      b_list
    end

    def off_broadway
      off_b_shows = []
      Shows.all.each do |show|
        if show.genre == "off-broadway"
          off_b_shows << show
        end
      end
      off_b_shows.sort {|x,y| x.name <=> y.name}
      off_b_list = off_b_shows.each_with_index do |show, index|
        puts "#{index+1}. #{show.name.titleize}"
      end
      off_b_list
    end

    def show_story
      puts "Please enter the name of a show or type 'exit' to return to main menu:"
      s = gets.strip.downcase
      show = Show.find_by_name(s)
      if show != nil
        puts "#{show.name.titleize} - #{show.story}"
        show_story
      elsif show == nil
        puts "Sorry, that's not a current show. Please try again."
        show_story
      end
      if s == 'exit'
        call
      end
    end
    
end