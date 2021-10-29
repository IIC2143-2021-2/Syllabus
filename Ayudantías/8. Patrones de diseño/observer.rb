# Crear la clase que funciona como subject
class Employee
    attr_reader :name, :job, :salary # Se define para que se puedan leer los atributos
    def initialize(name, job, salary)
        @name = name
        @job = job
        @salary = salary
        @observers = []
    end

    def add_observer(observer)
        @observers.append(observer)
    end

    def delete_observer(observer)
        @observers.delete(observer)
    end

    def notify_observers ()
        @observers.each do |observer|
            observer.update(self)
        end
    end

    def job=(new_job)
        @job = new_job
        notify_observers()
    end

    def salary=(new_salary)
        @salary = new_salary
        notify_observers()
    end
end




# Clase Observer
class JobsLog 
    def update(observer)
        puts "*** #{observer.name} es un #{observer.job} ***"
    end
end

# Clase Observer
class SalariesLog 
    def update(observer)
        puts "*** El sueldo de #{observer.name} es de #{observer.salary} ***"
    end
end






# Se prueba con las instancias entregadas
jaime = Employee.new('Jaime', 'Programador Junior', 1000000)
jobslog = JobsLog.new
salarieslog = SalariesLog.new
jaime.add_observer( jobslog )
jaime.add_observer( salarieslog )
jaime.job = "Programador"
jaime.salary = 1500000
jaime.delete_observer( jobslog )
jaime.job = "Programador Senior"
jaime.salary = 2000000