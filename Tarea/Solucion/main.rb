require_relative 'classes'
require_relative 'read'


DATABASE = ARGV[0]      # data -> clientes.csv ; trabajadores.csv ; pedidos.csv
INSTRUCTIONS = ARGV[1]  # instructions.txt
OUTPUT = ARGV[2]        # output.txt

class Main
    def initialize(database, instructions, output)
        @database = database
        @instructions = instructions
        @output = output
        @clients = Client.load_data(@database)
        @waiters = Waiter.load_data(@database)
        @orders = Order.load_data(@database)
        @dishes = Dish.load_data(@database)
    end

    def run() # without self 'cause it's a instance method
        delete_data(@output)
        read_instructions(@instructions).each do |instruction|
            self.log(self.action(instruction))
        end
    end

    def log(data)
        File.open(@output, "a") do |row|
            row.puts data
        end
    end

    def action(instruction)
        if instruction == "informacion_mesas"
            return self.tables
        elsif instruction == "generar_boletas"
            return self.generate_tickets
        elsif instruction == "top_mesas"
            return self.top_tables
        elsif instruction == "top_meseros"
            return self.top_waiters
        end
    end

    def tables
        data = []
        data.push("COMIENZA INFORMACION MESAS")
        # id_mesa nombre_mesero nombre_cliente
        information = []
        tables_available = []
        @clients.each do |client|
            numb_table = client.table
            unless tables_available.include? numb_table
                tables_available.push(numb_table)
                name_waiter = ""
                @waiters.each do |waiter|
                    waiter.tables.each do |table|
                        if table.to_i == numb_table
                            name_waiter = waiter.name
                        end
                    end
                end
                temp = "#{numb_table} #{name_waiter}"
                data_clients = [client.name]
                @clients.each do |client2|
                    if client.id != client2.id && client2.table == numb_table
                        data_clients.push(client2.name)
                    end
                end
                # https://www.rubyguides.com/2017/07/ruby-sort/
                data_clients = data_clients.sort #_by { |line| line.scan(/\d+/).first} # sort by name
                information.push("#{temp} #{data_clients.join(" ")}")
            end
        end
        # https://www.rubyguides.com/2017/07/ruby-sort/
        information = information.sort_by { |line| line.scan(/\d+/).first.to_i} # sort by id
        data.push(information)
        data.push("TERMINA INFORMACION MESAS")
        return data
    end

    def get_total_client(client)
        total = 0
        tip = 0
        cash_client = client.initial_cash

        @orders.each do |order|
            order.dishes.each do |data|
                data_id_dish = data[0]
                data_id_client = data[1]
                if client.id == data_id_client.to_i
                    @dishes.each do |dish|
                        if dish.id == data_id_dish.to_i
                            # puts("--- INFO CLIENTE #{client.name}")
                            # puts("CASH CLIENT #{client.cash}")
                            # puts("DISH PRICE #{dish.price}")
                            # puts("DISH TIP #{(dish.price * 0.1).ceil()}")
                            if ((cash_client - dish.price - (dish.price * 0.1).ceil()) >= 0)
                                total += dish.price
                                cash_client -= dish.price
                                tip += (dish.price * 0.1).ceil()
                                cash_client -= (dish.price * 0.1).ceil()
                                total += (dish.price * 0.1).ceil()
                            end
                        end
                    end
                end
            end
        end
        # actual_waiter.tip += tip
        return total, tip
    end

    def generate_tickets()
        data = []
        data.push("COMIENZA GENERAR BOLETAS")
        information = []
        tables_available = []
        top = []

        @clients.each do |client|
            total = 0
            numb_table = client.table
            unless tables_available.include? numb_table
                actual_waiter = ''
                @waiters.each do |waiter|
                    waiter.tables.each do |table|
                        if table.to_i == client.table
                            actual_waiter = waiter
                        end
                    end
                end
                tables_available.push(numb_table)
                temp = "#{numb_table}"
                cost, tip = get_total_client(client)
                client.cash -= cost
                actual_waiter.tip += tip
                total += cost
                data_clients = ["#{client.name} #{cost}"]
                @clients.each do |client2|
                    if client.id != client2.id && client2.table == numb_table
                        cost2, tip2 = get_total_client(client2)
                        client.cash -= cost
                        actual_waiter.tip += tip2
                        total += cost2
                        data_clients.push("#{client2.name} #{cost2}")
                    end
                end
                top.push("#{numb_table} #{total}")
                # https://www.rubyguides.com/2017/07/ruby-sort/
                data_clients = data_clients.sort # sort by name
                information.push("#{temp} #{data_clients.join(" ")} #{total}")
            end
        end
        # https://www.rubyguides.com/2017/07/ruby-sort/
        information = information.sort_by { |line| line.scan(/\d+/).first.to_i} # sort by id
        data.push(information)
        data.push("TERMINA GENERAR BOLETAS")
        # top_tables(top)
        return data
    end

    def top_tables()
        data = []
        data.push("COMIENZA TOP MESAS")
        top = []
        tables_available = []
        @clients.each do |client|
            total = 0
            numb_table = client.table
            unless tables_available.include? numb_table
                tables_available.push(numb_table)
                temp = "#{numb_table}"
                cost, tip = get_total_client(client)
                puts("CLIENTE #{client.name} total #{cost}")
                total += cost
                data_clients = ["#{client.name} #{cost}"]
                @clients.each do |client2|
                    if client.id != client2.id && client2.table == numb_table
                        cost2, tip2 = get_total_client(client2)
                        total += cost2
                        puts("CLIENTE #{client2.name} total #{cost2}")
                        data_clients.push("#{client2.name} #{cost2}")
                    end
                end
                puts("TOTAL MESA #{numb_table} total #{total}")
                top.push([numb_table, total])
                # https://www.rubyguides.com/2017/07/ruby-sort/
                data_clients = data_clients.sort # sort by name
            end
        end
        top.sort! {|x, y| -(x[1] <=> y[1])}
        puts("TOP TOP FINAL #{top}")
        final = []
        (0..2).each do |i|
            final.push(
                top[2 - i].join(" ")
            )
        end
        puts("FINAL FINAL #{final}")
        final = final.sort_by { |line| line.scan(/\d+/).first.to_i} # sort by id
        data.push(final)
        data.push("TERMINA TOP MESAS")
        return data
    end

    def top_waiters()
        data = []
        data.push("COMIENZA TOP MESEROS")
        info = []
        @waiters.each do |waiter|
            info.push([waiter.id, waiter.tip])
        end
        info.sort! {|x, y| -(x[1] <=> y[1])}
        final = []
        (0..2).each do |i|
            final.push(
                info[2 - i].join(" ")
            )
        end
        final = final.sort_by { |line| line.scan(/\d+/).first.to_i} # sort by id
        data.push(final)
        data.push("TERMINA TOP MESEROS")
        return data
    end

end

# https://stackoverflow.com/questions/2249310/if-name-main-equivalent-in-ruby
if __FILE__== $0
    main = Main.new(DATABASE, INSTRUCTIONS, OUTPUT)
    main.run()
end