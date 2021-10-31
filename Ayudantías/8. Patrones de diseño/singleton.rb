class Tablero
    attr_accessor :status

    @@instance = Tablero.new

    def self.instance
        return @@instance
    end

    private_class_method :new
end

tablero1 = Tablero.instance
tablero1.status = "on"
puts tablero1.status

tablero2 = Tablero.instance
puts tablero2.status

tablero3 = Tablero.new

#probar usando el .new en un tablero 3