def input_students
  puts "To finish, just hit return twice"
  # get the first name
  puts "Please enter the first name of the 1st student"
  name = gets.chomp
  # get the student's height
  puts "Please enter #{name}'s in cms"
  height = gets.chomp
  # get the student's hobby
  puts "Please enter #{name}'s hobby"
  hobby = gets.chomp
  # create an empty array
  students = []
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, height: height, hobby: hobby, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name and info from the user
    puts "Please enter the name of the next student"
    name = gets.chomp
    if name == ""
      break
    else
      puts "Please enter #{name}'s height in cms"
      height = gets.chomp
      puts "Please enter #{name}'s hobby"
      hobby = gets.chomp
    end
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]}, #{student[:height]}cm tall, likes #{student[:hobby]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
# nothing happens until we call the methods
print_header
print(students)
print_footer(students)