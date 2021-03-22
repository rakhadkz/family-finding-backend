Rake::Task.clear

class PaMeganSearchJob < ApplicationJob
  queue_as :default
  require 'watir'
  require 'webdrivers'

  def call(first_name, last_name)
    browser.goto(contact_form_url)
 
    puts('-----------1-----------------')
    puts('-----------1-----------------')
    puts(browser.html)
    puts('-----------1-----------------')
    puts('-----------1-----------------')

    accept_terms

    puts('-----------2-----------------')
    puts('-----------2-----------------')
    puts(browser.html)
    puts('-----------2-----------------')
    puts('-----------2-----------------')

    browser.goto('https://www.pameganslaw.state.pa.us/Search/NameSearch')

    puts('-----------3-----------------')
    puts('-----------3-----------------')
    puts(browser.html)
    puts('-----------3-----------------')
    puts('-----------3-----------------')

    fill_search_form(first_name, last_name)

    puts('-----------4-----------------')
    puts('-----------4-----------------')
    puts(browser.html)
    puts('-----------4-----------------')
    puts('-----------4-----------------')

    submit_search_form

    search_result = browser.div(:id, "nameSearchResults") 

    puts('-----------5-----------------')
    puts('-----------5-----------------')
    puts(search_result.html)
    puts('-----------5-----------------')
    puts('-----------5-----------------')

    description = search_result.html
 
    browser.close

    return description
    
  end

  def browser
    # @browser ||= Watir::Browser.new(:chrome) #this for testing on dev
    @browser ||= Watir::Browser.new(:chrome, browser_options)
  end
 
  def browser_options
    if chromedriver_binary_path.present?
      {
        headless: true,
        options: { binary: chromedriver_binary_path },
        switches: [
          '--ignore-certificate-errors',
          '--disable-popup-blocking',
          '--disable-translate',
          '--disable-gpu'
        ]
      }
    else
      {}
    end
  end

  def submit_search_form
    browser.button(class: 'btn btn-primary btn-sm').click
  end
 
  def fill_search_form(first_name, last_name)
    browser.text_field(id: 'enteredFirstName').set(first_name)
    browser.text_field(id: 'enteredLastName').set(last_name)
  end
 
  def accept_terms
    browser.button(class: 'btn btn-success btn-sm').click
  end
 
  def contact_form_url
    "https://www.pameganslaw.state.pa.us/"
  end
 
  def chromedriver_binary_path
    ENV['GOOGLE_CHROME_SHIM']
  end

  def perform(options)
    puts('==============JOBJOB==============', options.to_h,'4')
    description = call(options[:first_name], options[:last_name])

    family_search = FamilySearch.find(options[:family_search_id])
    puts('====================THIS IS DESCRIPTION===========================',description)
    unless family_search.nil?
      puts('-=================THIS IS FAMILY SEARCH EDIT')
      description = change_desc(description)
      family_search.description = description
      family_search.date_completed = DateTime.now
      family_search.save
    end
    puts family_search
  end

  private

  def change_desc(desc)
    desc = desc.to_s
    desc = desc.gsub(/<a.*?>|<\/a>/, '')
    desc = desc.gsub(/<onclick.*?>|<\/">/, '' )  
    desc
  end

end
