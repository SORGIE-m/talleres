persona = %{nombre: "Ana", edad: 30}
IO.inspect(persona) # => %{nombre: "Ana", edad: 30}

# Añadir una nueva clave-valor (o actualizar si ya existe)
persona_actualizada = %{persona | ciudad: "Barcelona"}
IO.inspect(persona_actualizada) # => %{ciudad: "Barcelona", nombre: "Ana", edad: 30}
# persona sigue siendo %{nombre: "Ana", edad: 30}

# Actualizar un valor existente
persona_mayor = %{persona | edad: 31}
IO.inspect(persona_mayor) # => %{nombre: "Ana", edad: 31}

# Con Map.put/3 (más explícito)
persona_con_profesion = Map.put(persona, :profesion, "Ingeniera")
IO.inspect(persona_con_profesion) # => %{nombre: "Ana", edad: 30, profesion: "Ingeniera"}

persona = %{nombre: "Ana", edad: 30, ciudad: "Madrid"}

# Eliminar una clave
persona_sin_ciudad = Map.delete(persona, :ciudad)
IO.inspect(persona_sin_ciudad) # => %{nombre: "Ana", edad: 30}


datos_basicos = %{nombre: "Ana", edad: 30}
datos_extra = %{ciudad: "Madrid", profesion: "Ingeniera"}

persona_completa = Map.merge(datos_basicos, datos_extra)
IO.inspect(persona_completa) # => %{nombre: "Ana", edad: 30, ciudad: "Madrid", profesion: "Ingeniera"}

# Sobrescritura
a = %{nombre: "Ana", edad: 30}
b = %{edad: 31, ciudad: "Barcelona"}
c = Map.merge(a, b)
IO.inspect(c) # => %{nombre: "Ana", edad: 31, ciudad: "Barcelona"}


persona = %{nombre: "Ana", edad: 30, ciudad: "Madrid"}

# Usando Enum.map para transformar
nuevo_mapa = Enum.map(persona, fn {clave, valor} ->
  {"#{clave}_modificada", "#{valor}!!!"}
end)
IO.inspect(nuevo_mapa)
# => [{"nombre_modificada", "Ana!!!"}, {"edad_modificada", "30!!!"}, {"ciudad_modificada", "Madrid!!!"}]
# ¡Ojo! Esto devuelve una lista, no un mapa.

# Para mantener la estructura de mapa, podemos usar Map.new/1
nuevo_mapa = Map.new(persona, fn {clave, valor} ->
  {clave, "#{valor}!!!"}
end)
IO.inspect(nuevo_mapa) # => %{nombre: "Ana!!!", edad: "30!!!", ciudad: "Madrid!!!"}


persona = %{nombre: "Ana", edad: 30, ciudad: "Madrid", altura: 1.75}

# Filtrar por una condición en los valores
mayor_de_25 = Map.filter(persona, fn {_clave, valor} -> is_number(valor) and valor > 25 end)
IO.inspect(mayor_de_25) # => %{edad: 30, altura: 1.75}


#Función	Descripción	Ejemplo
#Map.get/3	Obtiene un valor. Acepta un valor por defecto.	Map.get(map, :key, "default")
#Map.put/3	Inserta o actualiza una clave-valor.	Map.put(map, :new_key, "value")
#Map.delete/2	Elimina una clave del mapa.	Map.delete(map, :key_to_delete)
#Map.merge/2	Fusiona dos mapas.	Map.merge(map1, map2)
#Map.keys/1	Devuelve una lista con todas las claves.	Map.keys(%{a: 1, b: 2}) # => [:a, :b]
#Map.values/1	Devuelve una lista con todos los valores.	Map.values(%{a: 1, b: 2}) # => [1, 2]
#Map.has_key?/2	Verifica si una clave existe.	Map.has_key?(map, :key) # => true/false
#Map.pop/3	Extrae el valor de una clave y devuelve {valor, mapa_sin_la_clave}.	{valor, nuevo_mapa} = Map.pop(map, :key)
#Map.replace!/3	Reemplaza el valor de una clave existente. Falla si no existe.	Map.replace!(map, :existing_key, "new_value")
#Map.update!/3	Actualiza el valor de una clave existente con una función. Falla si no existe.	Map.update!(map, :age, fn age -> age + 1 end)
#Map.update/4	Actualiza una clave. Si no existe, inserta un valor por defecto.	Map.update(map, :age, 0, fn age -> age + 1 end)
