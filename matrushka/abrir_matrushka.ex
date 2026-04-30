defmodule Numeros do
  def main do
     lista = [1,2,3,4,5,6,7,8,9,10]
    imprimir(lista)
  def imprimir(lista), do: :ok  # Caso base: cuando llega a 0, termina

  def imprimir(x| lista) do
    IO.puts("#{x}")              # Imprime el número actual
    imprimir(lista)         # Llama a sí misma con n-1
  end
end
end
