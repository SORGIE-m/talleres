defmodule Util do
  def mostrar_mensaje(mensaje) do
    System.cmd("java",["-cp", "." ,"Mensajes",mensaje])
  end
end
