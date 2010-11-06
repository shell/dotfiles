require 'rubygems'
require 'hirb'
require 'ap'
require 'irb/completion'
require 'wirble' 
require 'looksee/shortcuts'
require 'ruby-debug/completion'

                 
Wirble.init
Wirble.colorize
Hirb::View.enable

# bind "^R" em-inc-search-prev

# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200

# Rails on-screen logging
def change_log(stream)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
end
     
def show_log
  change_log(STDOUT)

  puts "SQL log enabled. Enter 'reload!' to reload all loaded ActiveRecord classes"
end
        
def hide_log
  change_log(nil)

  puts "SQL log disabled. Enter 'reload!' to reload all loaded ActiveRecord classes"
end

# Simple benchmarking

def time(times = 1)
  require 'benchmark'

  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end

class Class
  def class_methods
     (methods - Class.instance_methods - Object.methods).sort
  end
end

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# SQL query execution

def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end