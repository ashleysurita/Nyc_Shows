class NycShows::Scraper
  
    @@pages = ["https://www.broadway.com/shows/tickets/", "https://www.broadway.com/shows/tickets/?page=2", "https://www.broadway.com/shows/tickets/?page=3"]
  
    def self.scrape_home_page
      @@pages.each do |page|  
        html = Nokogiri::HTML(open(page))
        # flex = html.css('div.flex-grid.flex-grid--bsrow')
        grid = html.css('div.card.card--hover.card--shadow.bg-white.mtn')
        grid.each do |show|
          name = show.css('div.media-body h2 a').text
          show_url = show.css('div.media-body h2 a.link-111-111').attribute('href').value
          show_hash = {:name => name.downcase, :url => "https://www.broadway.com#{show_url}"}
          NycShows::Show.new(show_hash)
        end
      end
    end
    
    def self.add_attr
      self.scrape_home_page.each do |show|
        info = self.show_info(show)
        show.add_show_attributes(info)
      end
    end

    def self.show_info(url)
      html = Nokogiri::HTML(open(url))
      show_info = {}
      show_info[:name] = html.css('h1.wht-lt.large-heading.font-charlie.text-shadow-md.mtm').text.downcase
      show_info[:story] = html.css('div.gray-dk.inner-content-bold p').text.downcase
      s_bar = html.css('div.ptx')
      show_info[:location] = s_bar.css('a.block.blue-link-lt.lh-norm').text.downcase
      binding.pry
      show_info[:duration] = s_bar.css('div.wht-md')[3].text.downcase #returning empty array
      show_info[:genre] = s_bar.css('li.standard-list__list-item.standard-list__list-item_tighter')[0].text.strip.downcase
      show_info
    end
      
end