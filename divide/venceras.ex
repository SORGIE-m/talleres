defmodule Suma do
  # ============================================
  # MAIN: Punto de entrada del programa
  # ============================================
  def main do
    IO.puts("\n=== SUMA CON DIVIDE Y VENCERÁS ===\n")

    # Lista de ejemplo
    lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    # Mostrar la lista
    IO.puts("Lista original: #{inspect(lista)}")

    # Llamar a la función sumar
    resultado = sumar(lista)

    # Mostrar el resultado
    IO.puts("La suma total es: #{resultado}")

    # Probar con otra lista
    IO.puts("\n--- Probando con otra lista ---")
    lista2 = [5, 10, 15, 20, 25]
    IO.puts("Lista: #{inspect(lista2)}")
    IO.puts("Suma: #{sumar(lista2)}")
  end

  # ============================================
  # FUNCIONES DEL ALGORITMO
  # ============================================

  # Caso base 1: lista vacía → suma = 0
  defp sumar([]), do: 0

  # Caso base 2: un solo elemento → suma = ese elemento
  defp sumar([x]), do: x

  # Caso recursivo: dividir en dos mitades
  defp sumar(lista) do
    # 1. DIVIDIR: separar la lista en dos partes
    {izquierda, derecha} = dividir(lista)

    # 2. RESOLVER: sumar cada parte (llamadas recursivas)
    suma_izquierda = sumar(izquierda)
    suma_derecha = sumar(derecha)

    # 3. COMBINAR: sumar los resultados
    suma_izquierda + suma_derecha
  end

  # Función auxiliar: divide una lista en dos mitades
  defp dividir(lista) do
    # Calcular la mitad (división entera)
    mitad = div(Enum.count(lista), 2)

    # Separar en dos listas
    izquierda = Enum.take(lista, mitad)   # Primeros elementos
    derecha = Enum.drop(lista, mitad)     # Resto de elementos

    # Retornar como tupla
    {izquierda, derecha}
  end
end

# ============================================
# EJECUTAR EL PROGRAMA
# ============================================
Suma.main()
