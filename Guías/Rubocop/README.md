# RuboCop

## ¿Qué es RuboCop?

RuboCop es un analizador de código estático para Ruby (también conocido como _linter_) y _formatter_ de código. Fuera de la caja, hará cumplir muchas de las pautas descritas en la Guía de estilo de Ruby de la comunidad. Además de informar los problemas descubiertos en su código, RuboCop también puede solucionar automáticamente muchos de ellos.

RuboCop es extremadamente flexible y la mayoría de los aspectos de su comportamiento se pueden modificar mediante varias opciones de configuración.

## ¿Cómo integrarlo en su proyecto?

Primero que todo es necesario instalarlo. Para esto agreguen la siguiente línea en su _Gemfile_:
```ruby
gem 'rubocop', require: false
```
y luego ejecuten:
```bash
bundle install
```

Otra alternativa es simplemente ejecutar:
```bash
gem install rubocop
```

Por último, deben crear, en la raiz de su proyecto, un [archivo de configuración](https://docs.rubocop.org/rubocop/1.20/configuration.html) donde se definan las reglas a utilizar.

Si no saben cómo hacerlo, no se preocupen, [acá](./.rubocop.yml) les dejamos uno que pueden usar :grin:.

(_Créditos al crack de [@miortiz1](https://github.com/miortiz1)_)

## ¿Cómo ejecutar RuboCop?

La ejecución de RuboCop sin argumentos comprobará todos los archivos de Ruby en el directorio actual:

```bash
rubocop
```

También pueden ejecutar RuboCop en un modo de autocorrección, donde intentará solucionar automáticamente los problemas que encontró en su código:

```bash
rubocop -a
# o
rubocop --auto-correct
```
