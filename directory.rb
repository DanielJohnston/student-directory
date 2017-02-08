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
SAVE_FILE = "./student_list.csv"

def input_cohort
  puts "Enter a default cohort (current default is #{@default_cohort}):"
  cohort = gets.chomp
  if cohort != ""
    @default_cohort = cohort.to_sym
  end
end

def input_students
  puts "Please enter the names of students."
  puts "Double enter to finish entry"
  new_students = []
  name = gets.chomp
  while !name.empty? do
    puts "And the cohort (default: #{@default_cohort})"
    entered_cohort = gets.chomp
    if entered_cohort == ""
      cohort = @default_cohort
    else
      cohort = entered_cohort.to_sym
    end
    new_students << {name: name, cohort: cohort}
    puts "We have #{new_students.count} new students."
    name = gets.chomp
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
    puts 'There are no @students enrolled!'
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
  CSV.open(SAVE_FILE, "wb") do |csv_file|
    @students.each do |student|
      csv_file << [student[:name], student[:cohort]]
    end
  end
end

def load_list
  @students = []
  CSV.foreach(SAVE_FILE) do |row|
    @students << {name: row[0], cohort: row[1].to_sym}
  end
  # csv_file.each do |student_line|
  #   puts student_line
  # end
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
@default_cohort = DEFAULT_COHORT
@students = []
choice = ""
until choice == "q"
  show_menu
  choice = gets.chomp
  act_on choice
end
