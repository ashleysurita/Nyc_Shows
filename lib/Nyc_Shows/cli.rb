class NycShows::CLI
  
  def call
    NycShows::Scraper.scrape_home_page
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
     case input
       when "shows"
        all_shows
       when "broadway"
         show_type(input)
       when "off-broadway"
         show_type(input)
       when "story"
         show_story
       when "exit"
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
    
    def get_shows(input)
      shows = NycShows::Show.all
      shows.collect do |show| 
        if show.genre == input
          show.name
        end
      end
    end
      
    def show_type(input)
      shows = get_shows(input).delete_if {|name| name == nil}
      sort_list = shows.sort {|x,y| x <=> y}
      puts "#{input.capitalize} Shows:"
      sort_list.each_with_index do |show, index|
        puts "#{index+1}. #{show.capitalize}"
      end
      command
    end

    def show_story
      @show = NycShows::Show
      puts "Please enter the name of a show or type 'exit' to return to main menu:"
      input = gets.strip.downcase
      case input
        when "exit"
          command
        else
          show = @show.find_by_name(input)
          if show != nil
            puts "#{show.name.capitalize} - #{show.story}"
            input = 'exit'
            show_story
          elsif show == nil
            puts "Sorry, that's not a current show. Please try again."
            show_story
          end
      end
    end
    
end