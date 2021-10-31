# a)
# Las clases son pizzeria, hamburgueseria, ensaladeria
class AbstractFactory
    def new_p1(number)
    end
    def new_p2(number)
    end
end

class Pizzeria < AbstractFactory
    def new_p1(number) 
        Pepperoni.new(number) 
    end 
    def new_p2(number) 
        Vegetarian.new(number) 
    end 
end 
class Hamburgueseria < AbstractFactory
    def new_p1(number) 
        Regular.new(number) 
    end 
    def new_p2(number) 
        Not_meat.new(number) 
    end 
end 
class Ensaladeria < AbstractFactory
    def new_p1(number) 
        Cesar.new(number) 
    end 
    def new_p2(number) 
        Mediterranean.new(number) 
    end 
end

# Productos concretos son las clases pepperoni, vegetarian, regular, not_meat, cesar, mediterranean

class Pepperoni 
    def initialize (number) 
        @name = 'pizza peperoni ' + number 
    end 
    def reveal 
        return @name + ' saliendo' 
    end 
end 
class Vegetarian 
    def initialize (number) 
        @name = 'pizza vegetariana ' + number 
    end 
    def reveal 
        return @name + ' saliendo' 
    end 
end 
class Regular 
    def initialize (number) 
        @name = 'hamburguesa regular ' + number 
    end 
    def reveal 
        return @name + ' saliendo' 
    end 
end
class Not_meat 
    def initialize (number) 
        @name = 'hamburguesa not_meat ' + number 
    end 
    def reveal 
        return @name + ' saliendo' 
    end 
end 
class Cesar 
    def initialize (number) 
        @name = 'ensalada cesar ' + number 
    end 
    def reveal 
        return @name + ' saliendo' 
    end 
end 
class Mediterranean 
    def initialize (number) 
        @name = 'ensalada mediterranea ' + number 
    end 
    def reveal 
        return @name + ' saliendo' 
    end 
end

# b)

class Negocio 
    def initialize(meal_factory, number_product_1, number_product_2) 
        @the_factory = meal_factory 
        @p1s = [] 
        number_product_1.times do |i| 
            p1 = @the_factory.new_p1("#{i+1}") 
            @p1s << p1 
        end 
        @p2s = [] 
        number_product_2.times do |i| 
            p2 = @the_factory.new_p2("#{i+1}") 
            @p2s << p2 
        end 
    end 
    def simular 
        @p1s.each {|p1| puts(p1.reveal)} 
        @p2s.each {|p2| puts(p2.reveal)} 
    end 
end 

(Negocio.new(Hamburgueseria.new,3,1)).simular 
(Negocio.new(Pizzeria.new,2,3)).simular 
(Negocio.new(Ensaladeria.new,4,1)).simular