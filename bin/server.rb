require 'webrick'
require 'socket'
require 'timeout'
require 'uri'
require 'erb'
require 'json'
require 'pry'
require_relative '../config/router'
require_relative '../app/controllers/application_controller'
require_relative '../lib/all'

module App
  # Place all data here inside of a method
  def App.posts
    # This is an example
    @all_posts ||= [
      (Post.new(1, "First day of school", "Jared Powers", "Today was the first day of school. It went really well. My classmates are great")),
      (Post.new(2, "Second day of school", "Jared Powers", "Today was the second day of class. That is all.")),
      (Post.new(3, "Third day of school", "Jared Powers", "Today is the third day of class. It is starting to get hard")),
      (Post.new(4, "Fourth day of school", "Jared Powers", "Today is the fourth day of class. It is just getting harder and harder.")),
      (Post.new(5, "Fifth day of school", "Jared Powers", "Today is the fifth day of class. This is my nightmare."))
    ]
  end
  def App.comments
    @all_pcomments ||= [
      (Comment.new(1, "Have fun on your first day!", "Anita Hebert", 1)),
      (Comment.new(2, "You can do it!!", "Hugh Devore", 2)),
      (Comment.new(3, "Never Surrender!!", "Old Ironsides", 2)),
      (Comment.new(4, "Grab me a reese's on your way home", "Colin Stadler", 4)),
      (Comment.new(5, "RUBY RUBY RUBY!!!", "Justin Herrick", 5))
    ]
  end
end

system('clear')

def start_custom_webbrick_server
  server = WEBrick::HTTPServer.new(Port: 3001)
  server.mount "/", WEBBrickServer

  trap(:INT)  { server.shutdown }
  trap(:TERM) { server.shutdown }

  puts "The server is running and awaiting requests at http://localhost:3001/"
  server.start
end

def start_custom_tcp_server
  CustomTCPServer.new.start
end


if ARGV[0] == '--no-webrick'
  start_custom_tcp_server
else
  start_custom_webbrick_server
end
