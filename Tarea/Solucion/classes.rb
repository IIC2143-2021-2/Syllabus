class Person
    attr_accessor :id, :name
    def initialize(id, name)
        @id = id.to_i
        @name = name
    end
end

class Client < Person
    attr_accessor :table, :total, :cash, :initial_cash
    def initialize(id, name, cash, table)
        super(id, name)
        @initial_cash = cash.to_i
        @cash = cash.to_i
        @table = table.to_i
        @total = 0
    end

    def self.load_data(database) # self 'cause it's a method class (Client.load_data)
        data = read_data("#{database}/clientes.csv")
        clients = []
        data.each do |row|
            clients.push(Client.new(
                row[:id], 
                row[:nombre], 
                row[:dinero],
                row[:mesa]
            ))
        end
        return clients
    end
end

class Waiter < Person
    attr_accessor :tables, :tip
    def initialize(id, name, tables, tip)
        super(id, name)
        @tables = tables
        @tip = tip.to_i
    end

    def self.load_data(database)
        data = read_data("#{database}/meseros.csv")
        waiters = []
        data.each do |row|
            waiters.push(Waiter.new(
                row[:id], 
                row[:nombre], 
                row[:mesas].split(":"),
                row[:propina]
            ))
        end
        return waiters
    end
end

class Dish
    attr_accessor :id, :price
    def initialize(id, name, price)
        @id = id.to_i
        @name = name
        @price = price.to_i
    end

    def self.load_data(database)
        data = read_data("#{database}/platillos.csv")
        dishes = []
        data.each do |row|
            dishes.push(Dish.new(
                row[:id], 
                row[:nombre], 
                row[:precio]
            ))
        end
        return dishes
    end
end

class Order
    attr_accessor :table, :dishes # id platillo, id client
    def initialize(id, table, dishes)
        @id = id.to_i
        @table = table.to_i
        @dishes = dishes
    end

    def self.load_data(database)
        data = read_data("#{database}/pedidos.csv")
        orders = []
        data.each do |row|
            info_dishes = row[:platillos].split(":")
            index = 0
            while index < info_dishes.length
                info_dishes[index] = info_dishes[index].split("-")
                index += 1
            end
            orders.push(Order.new(
                row[:id], 
                row[:mesa], 
                info_dishes
            ))
        end
        return orders
    end
end
