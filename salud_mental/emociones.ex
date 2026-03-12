# ============================================
# Estructura para guardar una emoción
# ============================================
# Emocion: Define qué propiedades tiene cada emoción (clave-valor)
#   - id: Número único que identifica la emoción
#   - nombre: Texto con el tipo de emoción (\"feliz\", \"triste\", etc)
#   - intensidad: Número del 1-10 que dice qué tan fuerte es
defmodule Emocion do
  defstruct [:id, :nombre, :intensidad]
end

defmodule Diario do
  # ============================================
  # DATOS INICIALES
  # ============================================
  # iniciar: Carga las emociones de ejemplo al principio
  # Devuelve una lista con 4 emociones predefinidas para empezar
  def iniciar do
    [
      %Emocion{id: 1, nombre: "feliz", intensidad: 8},
      %Emocion{id: 2, nombre: "triste", intensidad: 4},
      %Emocion{id: 3, nombre: "feliz", intensidad: 9},
      %Emocion{id: 4, nombre: "cansado", intensidad: 3}
    ]
  end

  # ============================================
  # CREATE - Agregar
  # ============================================
  # agregar: Añade una nueva emoción a la lista
  # Busca el ID más alto que existe, le suma 1, y crea la nueva emoción
  # Devuelve la lista original + la nueva emoción al final
  def agregar(lista, nombre, intensidad) do
    ultimo_id = case Enum.map(lista, fn e -> e.id end) do
      [] -> 0
      ids -> Enum.max(ids)
    end

    nuevo = %Emocion{id: ultimo_id + 1, nombre: nombre, intensidad: intensidad}
    lista ++ [nuevo]
  end

  # ============================================
  # READ - Consultas/Búsquedas
  # ============================================
  # ver_todas: Simplemente devuelve toda la lista de emociones
  # No hace ningún filtro, solo muestra todo tal como está
  def ver_todas(lista), do: lista

  # buscar_por_id: Busca UNA emoción específica por su ID
  # Si la encuentra, devuelve {:ok, emoción}
  # Si no existe, devuelve {:error, "No encontrado"}
  def buscar_por_id(lista, id) do
    case Enum.find(lista, fn e -> e.id == id end) do
      nil -> {:error, "No encontrado"}
      e -> {:ok, e}
    end
  end

  # filtrar_por_nombre: Busca TODAS las emociones con un nombre específico
  # Por ejemplo, todas las que digan "feliz"  Devuelve una lista (puede estar vacía)
  def filtrar_por_nombre(lista, nombre) do
    Enum.filter(lista, fn e -> e.nombre == nombre end)
  end

  # intensidad_alta: Busca TODAS las emociones "fuertes" (intensidad >= 7)
  # Devuelve una lista solo con las emociones que son muy intensas
  def intensidad_alta(lista) do
    Enum.filter(lista, fn e -> e.intensidad >= 7 end)
  end

  # ============================================
  # UPDATE - Modificar
  # ============================================
  # actualizar: Cambia el nombre y/o intensidad de una emoción existente
  # Busca la emoción por ID, la modifica, y devuelve la lista actualizada
  def actualizar(lista, id, nuevo_nombre, nueva_intensidad) do
    Enum.map(lista, fn e ->
      if e.id == id do
        %Emocion{e | nombre: nuevo_nombre, intensidad: nueva_intensidad}
      else
        e
      end
    end)
  end

  # ============================================
  # DELETE - Eliminar
  # ============================================
  # eliminar: Borra una emoción de la lista usando su ID
  # Si la encuentra, devuelve {:ok, lista_sin_esa_emoción}
  # Si no existe ese ID, devuelve {:error, mensaje de error}
  def eliminar(lista, id) do
    case Enum.find(lista, fn e -> e.id == id end) do
      nil ->
        {:error, "El ID #{id} no existe"}
      _ ->
        nueva_lista = Enum.filter(lista, fn e -> e.id != id end)
        {:ok, nueva_lista}
    end
  end

  # ============================================
  # ESTADÍSTICAS - Análisis
  # ============================================
  # resumen: Calcula números útiles sobre todas las emociones
  # Devuelve un mapa con:
  #   - total: cuántas emociones hay
  #   - felices: cuántas son "feliz"
  #   - intensidad_promedio: promedio de intensidad (suma / cantidad)
  def resumen(lista) do
    %{
      total: Enum.count(lista),
      felices: Enum.count(Enum.filter(lista, fn e -> e.nombre == "feliz" end)),
      intensidad_promedio:
        if Enum.empty?(lista) do
          0
        else
          Enum.sum(Enum.map(lista, fn e -> e.intensidad end)) / Enum.count(lista)
        end
    }
  end
end

# ============================================
# INTERFAZ DE USUARIO - El menú interactivo
# ============================================
defmodule App do
  # run: Inicia la aplicación
  # Carga los datos iniciales y abre el menú principal
  def run do
    data = Diario.iniciar()
    menu(data)
  end

  # menu: Genera el menú repetitivo
  # Muestra opciones, lee lo que el usuario elige, ejecuta la acción
  # y luego vuelve a mostrar el menú (ciclo infinito hasta que escriba "0")
  defp menu(data) do
    IO.puts("\n=== MIS EMOCIONES ===")
    IO.puts("1. Ver todas")
    IO.puts("2. Buscar por ID")
    IO.puts("3. Filtrar por nombre")
    IO.puts("4. Ver intensas (>=7)")
    IO.puts("5. Agregar nueva")
    IO.puts("6. Actualizar")
    IO.puts("7. Eliminar")
    IO.puts("8. Ver estadísticas")
    IO.puts("0. Salir")

    opcion = IO.gets("Opción: ") |> String.trim()

    case opcion do
      "1" ->
        Enum.each(data, fn e ->
          IO.puts("#{e.id}: #{e.nombre} (#{e.intensidad})")
        end)
        esperar()
        menu(data)


      "2" ->
        id = IO.gets("ID a buscar: ") |> String.trim() |> String.to_integer()

        case Diario.buscar_por_id(data, id) do
          {:ok, e} ->
            IO.puts("\n✅ Encontrado:")
            IO.puts("ID: #{e.id} | #{e.nombre} | Intensidad: #{e.intensidad}")
          {:error, msg} ->
            IO.puts("❌ #{msg}")
        end
        esperar()
        menu(data)


      "3" ->
        nombre = IO.gets("Nombre a filtrar (feliz/triste/cansado): ") |> String.trim()
        resultados = Diario.filtrar_por_nombre(data, nombre)

        if Enum.empty?(resultados) do
          IO.puts("No hay emociones '#{nombre}'")
        else
          Enum.each(resultados, fn e ->
            IO.puts("#{e.id}: #{e.nombre} (#{e.intensidad})")
          end)
        end
        esperar()
        menu(data)

      "4" ->
        resultados = Diario.intensidad_alta(data)

        if Enum.empty?(resultados) do
          IO.puts("No hay emociones intensas")
        else
          Enum.each(resultados, fn e ->
            IO.puts("#{e.id}: #{e.nombre} (#{e.intensidad})")
          end)
        end
        esperar()
        menu(data)

      "5" ->  # Agregar
        nombre = IO.gets("Nombre (feliz/triste/cansado): ") |> String.trim()
        intensidad = IO.gets("Intensidad (1-10): ") |> String.trim() |> String.to_integer()
        nueva_data = Diario.agregar(data, nombre, intensidad)
        IO.puts("✅ Agregado")
        esperar()
        menu(nueva_data)

      "6" ->  # Actualizar
        id = IO.gets("ID a actualizar: ") |> String.trim() |> String.to_integer()
        nombre = IO.gets("Nuevo nombre: ") |> String.trim()
        intensidad = IO.gets("Nueva intensidad: ") |> String.trim() |> String.to_integer()
        nueva_data = Diario.actualizar(data, id, nombre, intensidad)
        IO.puts("✅ Actualizado")
        esperar()
        menu(nueva_data)

      "7" ->  # Eliminar
        id = IO.gets("ID a eliminar: ") |> String.trim() |> String.to_integer()

        case Diario.eliminar(data, id) do
          {:ok, nueva_data} ->
            IO.puts("✅ Eliminado correctamente")
            esperar()
            menu(nueva_data)

          {:error, mensaje} ->
            IO.puts("❌ #{mensaje}")
            esperar()
            menu(data)
        end

      "8" ->  # Estadísticas
        r = Diario.resumen(data)
        IO.puts("📊 Total: #{r.total}")
        IO.puts("😊 Felices: #{r.felices}")
        IO.puts("📈 Promedio: #{Float.round(r.intensidad_promedio, 1)}")
        esperar()
        menu(data)

      "0" -> IO.puts("👋 Hasta luego")
      _ ->
        IO.puts("Opción inválida")
        menu(data)
    end
  end

  # esperar: Pausa la ejecución hasta que el usuario presione Enter
  # Permite que el usuario lea el resultado antes de volver al menú
  defp esperar do
    IO.gets("Enter para continuar...")
  end
end

# ============================================
# Inicia la aplicación
# ============================================
App.run()
