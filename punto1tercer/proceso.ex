defmodule Proceso do
  def main do
    matriz = [
      [60, 22, 41, 5],
      [13, 33, 44, 5],
      [89, 10, 100, 99],
      [5, 101, 6, 34]
    ]

    t1 = Task.async(fn -> s1(matriz, 0, 0) end)
    t2 = Task.async(fn -> s2(matriz, 0, 0, 0) end)

    suma_debajo = Task.await(t1)
    {suma_total, total_elementos} = Task.await(t2)
    promedio = suma_total / total_elementos

    c = suma_debajo * promedio
    IO.puts("s3: c = #{suma_debajo} * #{promedio} = #{c}")
    IO.puts("s4: El valor de c es: #{c}")
  end

  def s1([], _fila_idx, suma), do: suma

  def s1([fila | resto], fila_idx, suma) do
    suma_fila = s1_fila(fila, fila_idx, 0, 0)
    s1(resto, fila_idx + 1, suma + suma_fila)
  end

  defp s1_fila([], _col_idx, _fila_idx, suma), do: suma

  defp s1_fila([head | tail], col_idx, fila_idx, suma) do
    if fila_idx > col_idx do
      s1_fila(tail, col_idx + 1, fila_idx, suma + head)
    else
      s1_fila(tail, col_idx + 1, fila_idx, suma)
    end
  end

  def s2([], _fila_idx, suma, cantidad), do: {suma, cantidad}

  def s2([fila | resto], fila_idx, suma, cantidad) do
    {suma_fila, cant_fila} = s2_fila(fila, 0, 0)
    s2(resto, fila_idx + 1, suma + suma_fila, cantidad + cant_fila)
  end

  defp s2_fila([], suma, cantidad), do: {suma, cantidad}

  defp s2_fila([head | tail], suma, cantidad) do
    s2_fila(tail, suma + head, cantidad + 1)
  end
end

Proceso.main()
