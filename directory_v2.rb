require 'csv'

@students = [] # an empty array accessible to all methods

# First method called - pre-loads students from a file if file exists
def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    preload_students_from_file(filename)
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
  puts "3. Save the current list of students to a file"
  puts "4. Load a list of students from a file"
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
      puts "\nGoodbye!\n "
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
    @students << {name: name, cohort: :novermber}
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
  # ask for the file name
  ask_for_filename
  # open the file for writing
  CSV.open(STDIN.gets.chomp, "w") { |csv|
  #iterate over the array of students
  @students.each do |student|
    csv << [student[:name], student[:cohort]]
  end
  }
  puts "\nNew students (if any) were successfully saved to the students.csv file\n "
end

# When 4 is selected by the user
def load_students_from_file
  ask_for_filename
  # open the file for reading
  CSV.foreach(STDIN.gets.chomp) { |row|
  add_students(row)
  }
  puts "\nStudents successfully loaded\n "
end

# Auxiliary method for try_load_students method
def preload_students_from_file(filename = "students.csv")
  # open the file for reading
  CSV.foreach(filename) { |row|
  add_students(row)
  }
end
  
# Auxiliary method for input_students method
def get_student_name
  puts "\nPlease enter the first names of the students"
  puts "(To finish, just hit return twice)\n "
  # get the first name
  STDIN.gets.chomp
end

# Auxiliary method for input_students and load_students_from_file methods
def add_students(row)
  @students << {name: row[0], cohort: row[1].to_sym}
end

# Auxiliary method for the save_students_to_file and load_students_from_file methods
def ask_for_filename
  puts "\nPlease enter the name of the file you wish to use\n "
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