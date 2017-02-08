# array of students

# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]

require 'csv'

SCREENWIDTH = 79
DEFAULT_COHORT = :november
DEFAULT_SAVE_FILE = "./student_list.csv"

def input_cohort
  @default_cohort = (gets_default 'Enter a default cohort', @default_cohort).to_sym
end

def input_students
  puts "Please enter the names of students."
  puts "Double enter to finish entry"
  new_students = []
  name = STDIN.gets.chomp
  while !name.empty? do
    cohort = (gets_default 'Which cohort', @default_cohort).to_sym
    new_students << {name: name, cohort: cohort}
    puts "We have #{new_students.count} new students."
    name = STDIN.gets.chomp
  end
  new_students
end

def print_header
  puts "The students of Villains Academy".center(SCREENWIDTH)
  puts "-------------".center(SCREENWIDTH)
end

def print_footer names
  # finally, we print the total number of students
  puts "Overall, we have #{ names.length } great student#{ 's' if names.length != 1 }"
end

def all_cohorts
  @students.map{ |student| student[:cohort] }.uniq
end

def print_students
  if @students.count == 0
    puts 'There are no students enrolled!'
    return
  end
  all_cohorts.each do |cohort|
    puts "Cohort: #{ cohort }".center(SCREENWIDTH)
    @students.select { |student| student[:cohort] == cohort }.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def save_list
  CSV.open(@save_file, "wb") do |csv_file|
    @students.each do |student|
      csv_file << [student[:name], student[:cohort]]
    end
  end
end

def load_list
  if File.exists?(@save_file)
    @students = []
    CSV.foreach(@save_file) do |row|
      @students << {name: row[0], cohort: row[1].to_sym}
    end
  end
  # csv_file.each do |student_line|
  #   puts student_line
  # end
end

def gets_default question, default
  puts "#{question} (default: #{default})"
  response = STDIN.gets.chomp
  if response == ""
    default
  else
    response
  end
end

def show_menu
  puts 'What would you like to do:'
  puts '1) Add students'
  puts '2) Change the default cohort'
  puts '3) Show the students'
  puts '4) Save the student list'
  puts '5) Load the student list'
  puts 'q) Quit'
end

def act_on choice
  case choice
  when '1'
    @students.concat input_students
  when '2'
    @default_cohort = input_cohort
  when '3'
    print_header
    print_students
    print_footer(@students)
  when '4'
    save_list
  when '5'
    load_list
  end
end

# control loop
@students = []
@save_file = DEFAULT_SAVE_FILE
@save_file = ARGV[0] if !ARGV[0].nil?
@default_cohort = DEFAULT_COHORT
load_list
choice = ""
until choice == "q"
  show_menu
  choice = STDIN.gets.chomp
  act_on choice
end
