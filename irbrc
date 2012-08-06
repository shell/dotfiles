require 'rubygems'
%w[rubygems wirble pp ap irb/completion irb/ext/save-history interactive_editor].each do |gem|
  begin
    require gem
  rescue LoadError => err
    warn "Please do: gem install #{gem.sub(/\/.*/,'')}"
  end
end

Wirble.init
Wirble.colorize
# Hirb::View.enable

# =======================
# = Convenience methods =
# =======================
alias q exit
alias e exit
# bind "^R" em-inc-search-prev
def r; reload! end


# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200

#######################
# print SQL to STDOUT #
#######################

# Rails 2
if ENV.include?('RAILS_ENV')
  unless Object.const_defined?('RAILS_DEFAULT_LOGGER')
    require 'logger'
    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  end
# Rails 3
elsif defined?(Rails)
  if Rails.logger
    Rails.logger = Logger.new(STDOUT)
    ActiveRecord::Base.logger = Rails.logger
  end
end

###########################
# Rails on-screen logging #
###########################
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

show_log

#######################
# Simple benchmarking #
#######################

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

if ENV.include?('RAILS_ENV')&& !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(SDTOUT))
end