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

def input_students cohort = :november
  puts "Please enter the names of students for the #{cohort} cohort."
  puts "Double enter to finish entry"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: cohort}
    puts "We have #{students.count} students."
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_footer names
  # finally, we print the total number of students
  puts "Overall, we have #{names.length} great students"
end

def print students
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

students = input_students :november
print_header
print(students)
print_footer(students)
