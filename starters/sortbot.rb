# Sortbot Solver.
require "net/http"
require "json"

def show_wait_cursor(seconds,fps=15)
  chars = %w[| / - \\]
  delay = 1.0/fps
  (seconds*fps).round.times{ |i|
    print chars[i % chars.length]
    sleep delay
    print "\b"
  }
end

def main
  puts "🤖 " *24
  puts "noop " *1000
  puts "🤖 " *24

  puts
  puts "🧮  " *10

  puts "\n\n👋 Hello from Sortbot 2000\n\n"

  puts "What is your GitHub username?\n\n"

  delay_messages = ['Hmmm', "I need to check with my boss.", "Hang on."]
  username_errors = [
    "Please enter a username",
    "C'mon, enter a username",
    "Hey, just the username please.",
    "All I'm asking for is a username here.",
    "OK but first your GitHub username."
  ]

  username = gets.delete("\n")

  while username.empty?
    puts username_errors.sample
    puts
    username = gets.delete("\n")
  end

  start = post_json('/sortbot/exam/start', { :login => username })

  puts "\n#{start["message"]}\n\n"

  set_path = start['nextSet']

  # get the first set
  next_set = get_json(set_path)

  # Answer each question, as log as we are correct
  loop do

    puts "Please organize this set."
    puts next_set['question'].to_s
    puts "\n\nEnter your order here, please.\n\n"

    # for manual entry
    #solution = gets.delete("\n")
    solution = next_set["question"].sort.join(',')
    puts solution
    puts "\n\nInteresting choice, let's see if it's correct...\n\n"

    show_wait_cursor(rand(0.5..3))

    if [1,2,3].sample===1
      puts "\n\n#{delay_messages.sample}\n\n"
      show_wait_cursor(rand(0.1..5))
    end

    # send to sortbot
    formatted_solution = solution.split(',').map {|i| (i.to_i.to_s != i) ? i: i.to_i }
    puts formatted_solution
    solution_result = send_solution(set_path, formatted_solution)

    if solution_result['result'] == 'finished'
      complete_exam(solution_result)
    elsif solution_result['result'] == 'success'
      puts "#{"👍 "*10}\n\n"
      puts "You're right! Let's see... here's the next set...\n\n"
      set_path = solution_result['nextSet']
      next_set = get_json(set_path)
    else
      puts "#{"💩 "*10}\n\n"
      puts "Sorry, that's not correct.\n\n"
    end
  end
end

def complete_exam(solution_result)
  puts "\n\n#{"🏆"*10}\n\n"
  puts "You did it! You completed the challenge in #{solution_result['elapsedTime']} milliseconds"
  puts "See your certificate at #{solution_result['certificate']}"
  puts "\n\nThank you for playing.\n\n"
  loop do
    puts "\nWould you like to play again? Y/N\n"
    continuePlaying = gets.delete("\n")
    if continuePlaying.downcase=="y"
      puts "\n\n👍 Awesome, let's play again...\n\n"
      main()
      break
    else
      puts "👋 Cool, bye bye"
      exit
    end
  end

end

def send_solution(path, solution)
  post_json(path, { :solution => solution })
end

# get data from the api and parse it into a ruby hash
def get_json(path)
  response = Net::HTTP.get_response(build_uri(path))
  result = JSON.parse(response.body)
  #puts "🤖 GET #{path}"
  #puts "HTTP #{response.code}"
  #puts JSON.pretty_generate(result)
  result
end

# post an answer to the noops api
def post_json(path, body)
  uri = build_uri(path)
  #puts "🤖 POST #{path}"
  #puts JSON.pretty_generate(body)

  post_request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  post_request.body = JSON.generate(body)

  response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => false) do |http|
    http.request(post_request)
  end

  #puts "HTTP #{response.code}"
  result = JSON.parse(response.body)
  #puts result[:result]
  result
end

def build_uri(path)
  URI.parse("https://api.noopschallenge.com" + path)
end

main()
