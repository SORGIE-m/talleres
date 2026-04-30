defmodule Util do
  # Muestra un mensaje en la consola
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end

  # Ingresa datos según el tipo especificado
  def ingresar(mensaje, tipo) do
    mostrar_mensaje(mensaje)
    entrada = IO.gets("") |> String.trim()

    case tipo do
      :texto ->
        entrada

      :entero ->
        case Integer.parse(entrada) do
          {numero, ""} -> numero
          _ -> ingresar("Valor inválido. Ingrese un número entero: ", :entero)
        end

      :real ->
        case Float.parse(entrada) do
          {numero, ""} -> numero
          _ -> ingresar("Valor inválido. Ingrese un número real: ", :real)
        end

      :boolean ->
        valor = ingresar(mensaje, :texto) |> String.downcase()
        Enum.member?(["si", "sí", "s"], valor)
    end
  end
end
