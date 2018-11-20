require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
    def self.scrape_home_page
      html = Nokogiri::HTML(open("https://www.broadway.com/shows/tickets/"))
      flex = html.css('div.flex-grid.flex-grid--bsrow')
      grid = flex.css('div.card.card--hover.card--shadow.bg-white.mtn')
      show_hash = []
      grid.each do |show|
        name = show.css('div.media-body h2 a').text
        show_url = show.css('div.media-body h2 a.link-111-111').attribute('href').value
        show = {:name => name.downcase, :show_url => show_url.downcase}
        show_hash << show
      end
      show_hash
    end

    def self.show_info(show_url)
      html = Nokogiri::HTML(open(show_url))
      show_info = {}
      show_info[:name] = html.css('h1.wht-lt.large-heading.font-charlie.text-shadow-md.mtm').text.downcase
      show_info[:story] = html.css('div.gray-dk.inner-content-bold p').text.downcase
      side_bar = html.css('div.ptx').downcase
      show_info[:location] = s_bar.css('a.block.blue-link-lt.lh-norm').text.downcase
      show_info[:duration] = s_bar.css('div.wht-md')[3].text.downcase
      show_info[:genre] = s_bar.css('li.standard-list__list-item.standard-list__list-item_tighter')[0].text.strip.downcase
      show_info
    end
    
    def self.make_shows
      self.scrape_home_page.each do |home_site|
        attr_hash = self.show_info(home_site[:show_url])
        show = Show.find_or_create_by_name(home_site[:name])
        show.url = home_site([:show_url])
        show.add_show_attributes(attr_hash)
      end
    end

end