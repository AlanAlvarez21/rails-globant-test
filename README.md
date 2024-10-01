
# Globant Ruby exercises 
Alan Daniel Alvarez Castro 01/10/2024


## Construir container:


```bash
bin/setup 
```

# Ejercicio 1

Clase y Método:

<img width="1033" alt="Captura de pantalla 2024-10-01 a la(s) 2 40 06 p m" src="https://github.com/user-attachments/assets/4fe95de9-df58-4b3c-a5bf-2a5e5ed46a24">


La clase se encuentra en **lib/digit_sum.rb**, para ejecutar clase SumOfDigits desde consola:
```bash
bin/rails c 
```

```bash
> SumOfDigits.sum(21)
=> 3
```

#### Ejecutar Test 
**spec/digit_sum_spec.rb**

<img width="867" alt="Captura de pantalla 2024-10-01 a la(s) 4 56 07 p m" src="https://github.com/user-attachments/assets/f094cce9-7777-4ea4-a171-494548e71566">

```bash 
bin/bundle exec rspec spec/sum_of_digits_spec.rb --format documentation
```
<img width="1171" alt="Captura de pantalla 2024-10-01 a la(s) 4 52 46 p m" src="https://github.com/user-attachments/assets/8796686d-d88d-4885-b1da-0ea14641a998">


# Ejercicio 2

### Caso 1:

```ruby
Employee.all.each do |emp| emp.addresses.each { |addr| puts addr.street } end
```
Número de consultas: 9 consultas en total.
 - La primera consulta es para obtener todos los empleados: SELECT * FROM employees.
 - Se realiza un consulta por cada empleado para obtener sus address, lo que genera 8 consultas más

<img width="1193" alt="Captura de pantalla 2024-10-01 a la(s) 2 27 47 p m" src="https://github.com/user-attachments/assets/1e701a3e-1a6f-4da0-95fb-1b5d6416ed25">

### Caso 2:

```ruby
Employee.joins(:addresses).all.each do |emp| emp.addresses.each { |addr| puts addr.street } end
```
 - Número de consultas: 1 consulta.
   - Consulta única: SELECT employees.*, addresses.* FROM employees INNER JOIN addresses ON addresses.employee_id = employees.id;
   - Este método realiza un INNER JOIN entre empleados y direcciones, recuperando todos los empleados y sus direcciones en una única consulta, no se generan consultas adicionales, lo que mejora la eficiencia.

<img width="1202" alt="Captura de pantalla 2024-10-01 a la(s) 2 28 22 p m" src="https://github.com/user-attachments/assets/659d6c5f-a890-4d6d-a817-e27d540bdf30">

### Caso 3:
```ruby
Employee.includes(:addresses).all.each do |emp| emp.addresses.each { |addr| puts addr.street } end
```

Número de consultas: 2 consultas(1 para empleados y 1 para todas las direcciones).
- El método includes(:addresses) utiliza eager loading, cargando los empleados y sus direcciones en dos consultas separadas:
  - Consulta 1: SELECT * FROM employees; (para obtener todos los empleados).
  - Consulta 2: SELECT * FROM addresses WHERE employee_id IN (1, 2, 3, ..., 8); (para obtener todas las direcciones de los empleados en una sola consulta).

  Al utilizar includes, se evita el problema del N+1 y se generan solo 2 consultas.

<img width="1246" alt="Captura de pantalla 2024-10-01 a la(s) 2 28 41 p m" src="https://github.com/user-attachments/assets/b8e3c037-4582-4642-947c-9fa548b7498b">


### Caso 4:
```ruby
Employee.joins(:addresses).includes(:addresses).all.each do |emp| emp.addresses.each { |addr| puts addr.street } end
```
Número de consultas: 1 consulta.
 - Consulta única: SELECT employees.*, addresses.* FROM employees INNER JOIN addresses ON addresses.employee_id = employees.id;
 - Aunque se ha llamado a includes, joins realiza el INNER JOIN y proporciona toda la información en una sola consulta. Por lo tanto, includes es redundante aquí y no se generan consultas adicionales.

<img width="1246" alt="Captura de pantalla 2024-10-01 a la(s) 2 29 07 p m" src="https://github.com/user-attachments/assets/3dc2e5ce-d587-4815-a412-3565aff981d4">


### Conclusión Ejercicio 2:

La consulta más rápida es la del escenario 2 y 4, ya que ambos utilizan un único INNER JOIN, realizando solo 1 consulta para obtener todos los empleados y sus direcciones. Esto es mucho más eficiente que los otros escenarios que requieren múltiples consultas.

- Escenario 2 y 4: 1 consulta (más rápida).
- Escenario 3: 2 consultas.
- Escenario 1: 9 consultas (menos eficiente debido al problema N+1)
