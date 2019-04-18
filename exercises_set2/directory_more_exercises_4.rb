@students = [] # an empty array accessible to all methods

# First method called - pre-loads students from a file if file exists
def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students_from_file(filename)
    puts "\nLoaded #{@students.count} students from #{filename}\n "
  else 
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

# Second method called - runs program
def interactive_menu
  # Repeat once a processs has been carried out
  loop do
  # Print the menu and ask the user what to do
    print_menu
  # Do what the user has selected (corresponding to the number entered by the user)
    selected_option(STDIN.gets.chomp)
  end
end

def print_menu
  puts "Enter the number of the option you wish to select:"
  puts "\n1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit\n "
end

def selected_option(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students_to_file
    when "4"
      load_students_from_file
    when "9"
      puts "\nGoodbye!"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

# When 1 is selected by the user
def input_students
  name = get_student_name
  # while name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_students(name, :november)
    puts "\nStudent successfully added.\nNow we have #{@students.count} students\n "
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

# When 2 is selected by the user
def show_students
  print_header
  print_student_list
  print_footer
end

# When 3 is selected by the user
def save_students_to_file
  # open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "\nNew students (if any) were successfully saved to the students.csv file\n "
end

# When 4 is selected by the user
def load_students_from_file(filename = "students.csv")
  # open the file for reading
  file = File.open(filename, "r")
  # iterate over each line in the file
  file.readlines.each do |line|
    # parallel assignment
    name, cohort = line.chomp.split(",")
    add_students(name, cohort.to_sym)
  end
  file.close
  puts "\nAny new students successfully loaded\n "
end
  
# Auxiliary method for input_students method
def get_student_name
  puts "\nPlease enter the first names of the students"
  puts "(To finish, just hit return twice)\n "
  # get the first name
  STDIN.gets.chomp
end

# Auxiliary method for input_students and load_students_from_file methods
def add_students(name, cohort)
  @students << {name: name, cohort: cohort}
end

# Auxiliary method for show_students method
def print_header
  puts "\nThe students of Villains Academy"
  puts "---------------\n "
end

# Auxiliary method for show_students method
def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

# Auxiliary method for show_students method
def print_footer
  puts "\nOverall, we have #{@students.count} great students\n "
end

# Pre-load list of students
try_load_students
# Run the program
interactive_menu