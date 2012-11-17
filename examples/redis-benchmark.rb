require 'redis'
require 'mysql2'
require 'pry'
require 'benchmark'
N = 1000

def mysql_benchmark(operation)
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "nosql")
  client.query("RESET QUERY CACHE")
  if operation == "read"
    Benchmark.measure do |x|
      1.upto(N) { |n| client.query("SELECT value FROM key_values WHERE id = #{n}") }
    end
  elsif operation == "write"
    client.query("DROP TABLE key_values")
    client.query("CREATE TABLE key_values ( id INT, value VARCHAR(255) )")
    Benchmark.measure do |x|
      1.upto(N) { |n| client.query("INSERT INTO key_values(id, value) VALUES('#{n}', 'foobar' )") }
    end
  end
end

def redis_benchmark(operation)
  client = Redis.new
  if operation == "read"
    Benchmark.measure do |x|
      1.upto(N) { |n| client.get(n.to_s) }
    end
  elsif operation == "write"
    client.flushdb
    Benchmark.measure do |x|
      1.upto(N) { |n| client.set(n.to_s, "foobar") }
    end
  end
end

if ARGV.count < 2
  puts "Usage <db type> read|write"
  exit
end

type, operation = ARGV[0], ARGV[1]

time = case type
       when /mysql/ then mysql_benchmark(operation)
       when /redis/ then redis_benchmark(operation)
       end
puts "Time: #{time.real}"
