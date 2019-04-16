def input_students
  puts "Please enter the name of the first student"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September",
  "August", "September", "October", "November", "December"]
  # get the first name
  name = gets.chomp
  puts "Which cohort month does #{name} belong to?"
  month = gets.chomp
  if month == ""
    month = "November"
  end
  while !months.include?(month) do
    puts "Was that a typo!? Please enter it again.."
    month = gets.chomp
  end
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: month.to_sym}
    puts "Now we have #{students.count} students"
    # get another name from the user
    puts "Next student please"
    name = gets.chomp
    if name == ""
      break
    else
      puts "Cohort month please"
      month = gets.chomp
      if month == ""
        month = "November"
      end
      while !months.include?(month) do
        puts "Was that a typo!? Please enter it again.."
        month = gets.chomp
      end
    end
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print_by_cohort(students)
  
  sort_by_cohort = {}
  
  students.each do |student|
    cohort = student[:cohort]
    
    if sort_by_cohort[cohort] == nil
      sort_by_cohort[cohort] = []
    end
    
    sort_by_cohort[cohort].push(student[:name])
    
  end
  puts "What cohort would you like to see?"
  month = gets.chomp
  puts sort_by_cohort[month.to_sym]
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
# nothing happens until we call the methods
print_by_cohort(students)
#print_header
#print(students)
#print_footer(students)