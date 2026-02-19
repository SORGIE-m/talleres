defmodule Util do
  def mostrar_mensaje(mensaje) do
    System.cmd("java", ["-cp", ".", "Mensajes", mensaje])
  end

  def ingresar(mensaje, :texto) do
    # Llama al programa Java para ingresar texto y capturar la entrada
    case System.cmd("java", ["-cp", ".", "Mensaje", "input", mensaje]) do
      {output, 0} ->
        IO.puts("Texto ingresado correctamente.")
        IO.puts("Entrada: #{output}")
        # Retorna la entrada sin espacios extra
        String.trim(output)

      {error, code} ->
        IO.puts("Error al ingresar el texto. Código: #{code}")
        IO.puts("Detalles: #{error}")
        nil
    end
  end

  def ingresar(mensaje) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end
end
