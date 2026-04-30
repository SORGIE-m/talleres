defmodule NumeroPerfecto do
  def main do
    numero = IO.gets("Introducir un número: ") |> String.trim() |> String.to_integer()

    resultado = es_perfecto(numero)
    IO.inspect(resultado)
  end

  def es_perfecto(numero) do
    suma_divisores = sumar_divisores_propios(numero, 1, 0)
    if suma_divisores == numero do
      {:ok, "es perfecto"}
    else
      {:error, "no es perfecto"}
    end
  end

  defp sumar_divisores_propios(numero, divisor, suma) when divisor >= numero do
    suma
  end

  defp sumar_divisores_propios(numero, divisor, suma) do
    if rem(numero, divisor) == 0 do
      sumar_divisores_propios(numero, divisor + 1, suma + divisor)
    else
      sumar_divisores_propios(numero, divisor + 1, suma)
    end
  end
end

NumeroPerfecto.main()
