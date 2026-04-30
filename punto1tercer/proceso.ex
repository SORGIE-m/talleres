defmodule Proceso do
  def main do
    matriz = [
      [60, 22, 41, 5],
      [13, 33, 44, 5],
      [89, 10, 100, 99],
      [5, 101, 6, 34]
    ]

    t1 = Task.async(fn -> s1(matriz) end)
    t2 = Task.async(fn -> s2(matriz) end)

    suma_debajo = Task.await(t1)
    promedio = Task.await(t2)

    IO.puts("DEBUG: suma_debajo = #{suma_debajo}")
    IO.puts("DEBUG: promedio = #{promedio}")

    t3 = Task.async(fn -> s3(suma_debajo, promedio) end)
    t4 = Task.async(fn -> s4(suma_debajo, promedio) end)

    Task.await(t3)
    Task.await(t4)
  end

  # s1: Suma debajo de diagonal - Versión CORREGIDA
  def s1(matriz) do
    matriz
    |> Enum.with_index()
    |> Enum.reduce(0, fn {fila, i}, acc_fila ->
      fila
      |> Enum.with_index()
      |> Enum.reduce(acc_fila, fn {valor, j}, acc_col ->
        if i > j do
          acc_col + valor
        else
          acc_col
        end
      end)
    end)
  end

  # s2: Promedio de todos los números
  def s2(matriz) do
    {suma, total} = matriz
    |> Enum.reduce({0, 0}, fn fila, {acc_sum, acc_count} ->
      {suma_fila, count_fila} = fila
      |> Enum.reduce({0, 0}, fn valor, {s, c} ->
        {s + valor, c + 1}
      end)
      {acc_sum + suma_fila, acc_count + count_fila}
    end)
    suma / total
  end

  def s3(suma_debajo, promedio) do
    c = suma_debajo * promedio
    IO.puts("s3: c = #{suma_debajo} * #{promedio} = #{c}")
    c
  end

  def s4(suma_debajo, promedio) do
    c = suma_debajo * promedio
    IO.puts("s4: El valor de c es: #{c}")
    c
  end
end

Proceso.main()
