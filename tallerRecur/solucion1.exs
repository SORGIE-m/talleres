defmodule Solucion1 do
  def main do
    palabra= IO.gets("introducir palabra a contar sus vocales:") |> String.trim |> String.graphemes

  contador= contar_vocales(palabra)
  IO.puts(contador)
  end

  def contar_vocales(palabra)do
  contar_vocales(palabra, 0)
  end

  defp contar_vocales([],contador)do
    contador
  end

  defp contar_vocales([head|tail],contador)do
    if head in ["a","e","i","o","u"] do
      contar_vocales(tail,contador + 1)
    else
      contar_vocales(tail,contador)
    end
  end
 end
 Solucion1.main()
