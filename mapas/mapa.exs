# Mapa vacío
mapa_vacio = %{}
IO.inspect(mapa_vacio) # => %{}

# Mapa con claves y valores
persona = %{
  :nombre => "Ana",
  :edad => 30,
  :ciudad => "Madrid"
}
IO.inspect(persona) # => %{ciudad: "Madrid", edad: 30, nombre: "Ana"}

# ¡Nota importante! Si todas tus claves son átomos, hay una sintaxis más dulce:
persona_sintaxis_dulce = %{
  nombre: "Ana",
  edad: 30,
  ciudad: "Madrid"
}
IO.inspect(persona_sintaxis_dulce) # => %{ciudad: "Madrid", edad: 30, nombre: "Ana"}

# Mezcla de tipos de claves
mapa_mixto = %{
  "nombre" => "Carlos",
  :edad => 25,
  1 => "uno"
}
IO.inspect(mapa_mixto) # => %{1 => "uno", :edad => 25, "nombre" => "Carlos"}

persona = %{nombre: "Ana", edad: 30, ciudad: "Madrid"}

# 1. La forma más común y rápida (cuando la clave es un átomo):
IO.puts(persona.nombre) # => "Ana"
IO.puts(persona.edad)   # => 30

# 2. Con el operador corchete [] (funciona con cualquier tipo de clave):
mapa_con_string = %{"nombre" => "Ana", :edad => 30}
IO.puts(mapa_con_string["nombre"]) # => "Ana"
IO.puts(mapa_con_string[:edad])    # => 30

# 3. Con la función Map.get/3 (buena para valores por defecto):
IO.puts(Map.get(persona, :ciudad))        # => "Madrid"
IO.puts(Map.get(persona, :pais, "No especificado")) # => "No especificado" (valor por defecto)

# 4. Safe navigation: Si la clave no existe y usamos la notación de punto, da error.
#    Para evitarlo, podemos usar Map.get/2 o pattern matching.
#    ¡Cuidado! persona.pais lanzaría un KeyError.
