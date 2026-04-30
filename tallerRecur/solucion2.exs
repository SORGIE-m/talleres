defmodule Solucion2 do
  def main do
    primero = IO.gets("Introducir primer numero: ") |> String.trim() |> String.to_integer()
    segundo = IO.gets("Introducir segundo numero: ") |> String.trim() |> String.to_integer()

    tupla = calcular_potencia(primero, segundo)
    IO.inspect(tupla)
  end

  def calcular_potencia(primero, segundo) do
    calcular_potencia(primero, segundo, 0)
  end

  defp calcular_potencia(primero, segundo, acomulador) do
    if :math.pow(primero, acomulador) > segundo do
      {:error, "no es potencia"}
    else
      if :math.pow(primero, acomulador) == segundo do
        {:ok, "son potencias"}
      else
        calcular_potencia(primero, segundo, acomulador + 1)
      end
    end
  end
end

Solucion2.main()
