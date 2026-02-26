##Abstraccion: un sistema para hacer validaciones de usuario. Informacion necesaria: recibe nombre de usuario, edad de usuario
#indicador que determine si posee credenciales boolean, numero de intentos fallidos, Evaluar


defmodule Plataforma do
  def main do
    nombre_usuario = Util.ingresar("Ingrese el nombre del usuario" ,:texto)
    edad_usaurio = Util.ingresar("Ingrese la edad del usuario", :entero)
    credenciales_usuario = Util.ingresar("Ingrese si posee credenciales (si, no): ", :boolean)
    intentos_fallidos = Util.ingresar("Ingrese el numero de intentos fallidos: ", entero)

    validacion = validar_usuario(nombre_usuario, edad_usuario, credenciales_usuario, intentos_fallidos)
    mostrar_resultado(validacion)
  end

  def validar_usuario(nombre, edad, credenciales, intentos) do
    unless credenciales do
      {:error, "el usuario #{nombre} no  tiene credenciales validas"}
    else
      if edad < 18 do
        {:error, "el usuario #{nombre} no  tiene edad suficiente"}
      else

        if intentos > 3 do
          {:error, "el usuario #{nombre} no  tiene intentos"}
        else
          {:ok, "Acceso concedido"}
        end
      end
    end

  end
end
