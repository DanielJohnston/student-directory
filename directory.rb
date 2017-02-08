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

SCREENWIDTH = 79
DEFAULT_COHORT = :november

def input_cohort
  puts "Enter a default cohort (current default is #{DEFAULT_COHORT}):"
  cohort = gets.chomp
  if cohort == ""
    DEFAULT_COHORT
  else
    cohort.to_sym
  end
end

def input_students default_cohort
  puts "Please enter the names of students."
  puts "Double enter to finish entry"
  students = []
  name = gets.chomp
  while !name.empty? do
    puts "And the cohort (default: #{default_cohort})"
    entered_cohort = gets.chomp
    if entered_cohort == ""
      cohort = default_cohort
    else
      cohort = entered_cohort.to_sym
    end
    students << {name: name, cohort: cohort}
    puts "We have #{students.count} students."
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy".center(SCREENWIDTH)
  puts "-------------".center(SCREENWIDTH)
end

def print_footer names
  # finally, we print the total number of students
  puts "Overall, we have #{ names.length } great student#{ 's' if names.length != 1 }"
end

def all_cohorts students
  students.map{ |student| student[:cohort] }.uniq
end

def print students
  if students.count == 0
    puts 'There are no students enrolled!'
    return
  end
  all_cohorts(students).each do |cohort|
    puts "Cohort: #{ cohort }".center(SCREENWIDTH)
    students.select { |student| student[:cohort] == cohort }.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end


# control loop
default_cohort = DEFAULT_COHORT
students = []
choice = ""
until choice == "q"
  puts 'What would you like to do:'
  puts '1) Add students'
  puts '2) Change the default cohort'
  puts '3) Show the students'
  puts 'q) Quit'
  choice = gets.chomp
  case choice
  when '1'
    students.concat input_students(default_cohort)
  when '2'
    default_cohort = input_cohort
  when '3'
    print_header
    print(students)
    print_footer(students)
  end
end
