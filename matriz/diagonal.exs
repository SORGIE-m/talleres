defmodule RecorrerDiagonal do
  def main do
    matriz = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ]
    acom = 0

    impresion = recorrer_matriz(matriz, acom, [])  # ← CAMBIO: guardar el resultado
    IO.inspect(impresion)
  end

  def recorrer_matriz([], _acom, impresion) do
    impresion
  end

  def recorrer_matriz([x|resto], acom, impresion) do
    nueva_impresion = impresion ++ [Enum.at(x, acom)]  # ← CAMBIO: usar nueva variable
    nuevo_acom = acom + 1                               # ← CAMBIO: nueva variable para acom
    recorrer_matriz(resto, nuevo_acom, nueva_impresion)
  end
end

RecorrerDiagonal.main()
