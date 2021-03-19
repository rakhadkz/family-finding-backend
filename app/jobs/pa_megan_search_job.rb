Rake::Task.clear

class PaMeganSearchJob < ApplicationJob
  queue_as :default
  require 'watir'
  include Services::Base

  def call(first_name, last_name)
    browser.goto(contact_form_url)
 
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts(browser.html)
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')

    accept_terms

    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts(browser.html)
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')

    browser.goto('https://www.pameganslaw.state.pa.us/Search/NameSearch')

    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts(browser.html)
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')

    fill_search_form(first_name, last_name)

    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts(browser.html)
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')

    submit_search_form

    search_result = browser.div(:id, "nameSearchResults")

    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts(search_result.html)
    puts('-----------AHAHHAAHHAHAHA-----------------')
    puts('-----------AHAHHAAHHAHAHA-----------------')


 
    Services::Result.new
    rescue => ex
      puts(ex)
    
      Services::Result.new(value: 'unknown_error', error_code: 500)
    ensure
      browser.close

    return search_result.html
    
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
      family_search.description = description
      family_search.date_completed = DateTime.now
      family_search.save
    end
    puts family_search
  end
end
