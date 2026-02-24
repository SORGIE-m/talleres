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




  def ingresar(mensaje, :entero) do
   try do
   mensaje
   |> ingresar(:texto)
   |> String.to_integer()
   rescue
    ArgumentError ->
    "Error, se espera que ingrese un número entero\n"
   |> mostrar_error()
   mensaje
   |> ingresar(:entero)
   end
  end


  def ingresar(mensaje, :texto) do
mensaje
|> IO.gets()
|> String.trim()
end

def ingresar(mensaje, :entero) do
mensaje
|> Util.ingresar(:texto)
|> String.to_integer()
end



def ingresar(mensaje, :entero) do
try do
mensaje
|> ingresar(:texto)
|> String.to_integer()
rescue
ArgumentError ->
"Error, se espera que ingrese un número entero\n"
|> mostrar_error()
mensaje
|> ingresar(:entero)
end
end


def mostrar_error(mensaje) do
IO.puts(:standard_error, mensaje)
end

def ingresar(mensaaje, :real) do
  try di
   mensaje
   |> ingresar( :texto)
   |> String.to_float()
 rescue
   ArgumentError ->
    "Error, se espera que ingrese un numero real\n"
    |> mostrar_error()

    mensaje
    |> ingresar( :real)
  end



  def ingresar(mensaje, :entero), do: ingresar(mensaje, &String.to_integer/1, :entero)
  def ingresar(mensaje, :real), do: ingresar(mensaje, &String.to_float/1, :real)


  def ingresar(mensaje, :entero) do
    ingresar(
      mensaje,
      &String.to_integer/1,
       :entero
    )
  end

  def ingresar(mensaje, :real) do
    ingresar(
      mensaje,
      &String.to_float/1,
       :real
    )
  end







end
