class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :print_message

  after_action :add
  def print_message
  puts "helo i am print message before every"
 end


 after_action :print_log

 def print_log
  puts "============================================================================="
  puts "i am print after every action runs in controller"
  puts "==============================================================================="
 end


 def add 

  a=34;
  b=90;

  puts  a+b;
 end
end
