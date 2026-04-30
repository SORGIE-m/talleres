defmodule Cliente do
  defstruct nombre: "", edad: 0, altura: 0.0

  def crear(nombre, edad, altura) do
    %Cliente{nombre: nombre, edad: edad, altura: altura}
  end

  def ingresar(mensaje) do
    IO.puts(mensaje)
    nombre = IO.gets("Nombre: ") |> String.trim()
    edad = IO.gets("Edad: ") |> String.trim() |> String.to_integer()
    altura = IO.gets("Altura: ") |> String.trim() |> String.to_float()
    crear(nombre, edad, altura)
  end

  def ingresar(mensaje, :clientes)do
   mensaje
   |> ingresar([], :clientes)
  end

  defp ingresar(mensaje, lista, :clientes)do
   cliente =
     mensaje
     |> ingresar()
    nueva_lista = lista ++ [cliente]

    mas_clientes =
      "\nIngresar mas clientes (s\n): "
      |> IO.gets("Altura: ") |> String.trim() |> String.to_boolean
     case mas_clientes do
      true ->
        mensaje
        |> ingresar(nueva_lista, :clientes)
      false ->
        nueva_lista
    end

  end

end
