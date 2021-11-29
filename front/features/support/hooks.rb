# frozen_string_literal: true

# utf-8
require_relative 'helper.rb'
require 'report_builder'
require 'date'
require 'json'



Before do
   Capybara.reset_session!
   page.driver.browser.manage.delete_all_cookies
end

def add_screenshot(scenario)
   sufix = ('error' if scenario.failed?) || 'success'
   name = scenario.name.tr(' ', '_').downcase
   foto = save_screenshot("images/#{sufix}-#{name}.png")
   base64_img = Base64.encode64(File.open(foto, 'rb:UTF-8', &:read))
   attach(base64_img, 'image/png;base64')
end
 
 def exception_message(scenario)
   scene = scenario.failed?
   return unless scene == true
 
   log("\n\n----------------------------------------------")
   log('Reason:')
   log(scenario.exception.message.to_s)
   log("----------------------------------------------\n\n")
end
 
 After do |scenario|
   add_screenshot(scenario)
   exception_message(scenario)
 end
 
 passed = 0
 failed = 0

 AfterConfiguration do |config|
   config.on_event(:test_case_finished) do |event|
     puts "\n\nResults:"
     puts '----------------------------------------------'
     puts "Scenario: #{event.test_case.name}"
     puts "The results is: #{event.result}"
     puts "----------------------------------------------\n\n"
 
     if event.result.ok?(:passed)
       passed += 1
     else
       failed += 1
     end
   end
  end
 
  
 at_exit do
   time = Time.now.strftime("%d/%m/%Y %H:%M")
   ReportBuilder.configure do |config|
     config.input_path = 'logs/report.json'
     config.report_path = 'logs/report'
     config.report_types = [:html]
     config.report_title = 'PF4 - Front End Regression Tests'
     #config.color = 'indigo'
     config.additional_info = { 'Browser': ENV['BROWSER'], 'Ambiente': ENV['TEST_ENV'], 'Horário': time }
  end
    ReportBuilder.build_report
  end


 