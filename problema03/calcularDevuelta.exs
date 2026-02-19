defmodule calcular_devuelta do
  def main do
  valor_total = "Ingrese el valor de la factura: "
  |> Util.ingresar ( :entero)

  valor_entregado = "Ingrese dinero proporcionado: "
  |> Util.ingresar ( :entero)

  calcular(valor_total, valor_entregado)
  |> generar_mensaje()
  |> Util.mostrar_mensaje()
end

defp generar_mensaje do
  
end
end
