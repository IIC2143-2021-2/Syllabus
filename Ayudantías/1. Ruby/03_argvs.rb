# ARGV: array with console-given arguments

# Get first console-given argument
first_element = ARGV[0]

# Get second console-given argument
second_element = ARGV[1]

ARGV[2] = "tercer elemento"


# Print both elements separated by a comma
puts "#{first_element}, #{second_element}"

print ARGV
