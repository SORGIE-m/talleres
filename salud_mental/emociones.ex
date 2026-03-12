defmodule Emocion do
  defstruct [:id, :nombre, :intensidad]
end

defmodule Diario do
  # ============================================
  # DATOS INICIALES (listas + mapas + tuplas + estructuras)
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
  # CREATE - Agregar
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
  # READ - Consultas (TODAS usan Enum)
  # ============================================
  def ver_todas(lista), do: lista

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
  # UPDATE - Actualizar
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
  # DELETE - Eliminar
  # ============================================
  def eliminar(lista, id) do
    Enum.filter(lista, fn e -> e.id != id end)
  end

  # ============================================
  # ESTADÍSTICAS (Enum + mapas)
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
# INTERFAZ EN CONSOLA (súper simple)
# ============================================
defmodule App do
  def run do
    data = Diario.iniciar()
    menu(data)
  end

  defp menu(data) do
    IO.puts("\n=== MIS EMOCIONES ===")
    IO.puts("1. Ver todas")
    IO.puts("2. Agregar")
    IO.puts("3. Actualizar")
    IO.puts("4. Eliminar")
    IO.puts("5. Ver estadísticas")
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
        nombre = IO.gets("Nombre (feliz/triste/cansado): ") |> String.trim()
        intensidad = IO.gets("Intensidad (1-10): ") |> String.trim() |> String.to_integer()
        nueva_data = Diario.agregar(data, nombre, intensidad)
        IO.puts("✅ Agregado")
        esperar()
        menu(nueva_data)

      "3" ->
        id = IO.gets("ID a actualizar: ") |> String.trim() |> String.to_integer()
        nombre = IO.gets("Nuevo nombre: ") |> String.trim()
        intensidad = IO.gets("Nueva intensidad: ") |> String.trim() |> String.to_integer()
        nueva_data = Diario.actualizar(data, id, nombre, intensidad)
        IO.puts("✅ Actualizado")
        esperar()
        menu(nueva_data)

      "4" ->
        id = IO.gets("ID a eliminar: ") |> String.trim() |> String.to_integer()
        nueva_data = Diario.eliminar(data, id)
        IO.puts("✅ Eliminado")
        esperar()
        menu(nueva_data)

      "5" ->
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
