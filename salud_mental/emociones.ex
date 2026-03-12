defmodule Emocion do
  defstruct [:id, :nombre, :intensidad]
end

defmodule Diario do
  # ============================================
  # DATOS INICIALES
  # ============================================
  def iniciar do
    [
      %Emocion{id: 1, nombre: "feliz", intensidad: 8},
      %Emocion{id: 2, nombre: "triste", intensidad: 4},
      %Emocion{id: 3, nombre: "feliz", intensidad: 9},
      %Emocion{id: 4, nombre: "cansado", intensidad: 3}
    ]
  end

  # ============================================
  # CREATE
  # ============================================
  def agregar(lista, nombre, intensidad) do
    ultimo_id = case Enum.map(lista, fn e -> e.id end) do
      [] -> 0
      ids -> Enum.max(ids)
    end

    nuevo = %Emocion{id: ultimo_id + 1, nombre: nombre, intensidad: intensidad}
    lista ++ [nuevo]
  end

  # ============================================
  # READ
  # ============================================
  def ver_todas(lista), do: lista

  # ✅ ESTA FUNCIÓN AHORA SÍ SE USA
  def buscar_por_id(lista, id) do
    case Enum.find(lista, fn e -> e.id == id end) do
      nil -> {:error, "No encontrado"}
      e -> {:ok, e}
    end
  end

  def filtrar_por_nombre(lista, nombre) do
    Enum.filter(lista, fn e -> e.nombre == nombre end)
  end

  def intensidad_alta(lista) do
    Enum.filter(lista, fn e -> e.intensidad >= 7 end)
  end

  # ============================================
  # UPDATE
  # ============================================
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
  # DELETE
  # ============================================
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
  # ESTADÍSTICAS
  # ============================================
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
# INTERFAZ DE USUARIO
# ============================================
defmodule App do
  def run do
    data = Diario.iniciar()
    menu(data)
  end

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

      # ✅ NUEVA OPCIÓN: Ver intensas
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

  defp esperar do
    IO.gets("Enter para continuar...")
  end
end

# Ejecutar
App.run()
