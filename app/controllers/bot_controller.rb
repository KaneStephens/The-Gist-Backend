class BotController < ApplicationController



  def search 
    word = params['word']
    result = searchyThing(word)
    render json: result
  end

  def searchyThing(word)
  # use this for the actual app
    browser = Watir::Browser.new :chrome, headless: true

    browser.goto("https://www.collinsdictionary.com/dictionary/english")

    browser.button(:text =>"I accept").wait_until(&:present?).click

    def etymology(text)
      if text 
        return text
      end
    end

    browser.text_field(placeholder: "English Dictionary").set word
    browser.button(type: "submit").click
    sleep 0.5
    doc = Nokogiri::HTML.parse(browser.html)
    
    {word: {definition: doc.css("div.def")[0].text,etymology: etymology(doc.css("div.etym")[0].text),frequency: doc.css("script#trendingWordsFrequency").text.split(" ")[4]}}
    
  end



end
