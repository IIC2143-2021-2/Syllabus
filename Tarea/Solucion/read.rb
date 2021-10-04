require 'csv'

def read_data(file)
    CSV.read(file, :headers => true, :header_converters => :symbol).map{ |data| data.to_h}
end

def read_instructions(file)
    File.readlines(file).map { |data| data.chomp}
end

def delete_data(file)
    # https://stackoverflow.com/questions/25269803/how-to-close-and-delete-a-file-in-ruby
    begin
        File.open(file, 'r') do |f|
          File.delete(f)
        end
    rescue Errno::ENOENT
    end
end


# https://stackoverflow.com/questions/2249310/if-name-main-equivalent-in-ruby
if __FILE__== $0
    puts read_data(ARGV[0])
    puts read_instructions(ARGV[1])
    delete_data(@output)
end
