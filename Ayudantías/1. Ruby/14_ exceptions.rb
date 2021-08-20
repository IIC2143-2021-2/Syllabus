begin ## Equivalent to try on python
    puts "me ejecuto"
    raise "un error"

rescue => error ## Except on python (you can also catch specific errors)
    puts error.message
end