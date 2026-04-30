defmodule Mensajes do
  def main do
    # Crear proceso "receptor"
    receptor_pid = spawn(fn -> receptor() end)

    # Crear proceso "emisor" que envía mensajes
    spawn(fn -> emisor(receptor_pid, 5) end)

    # Dar tiempo
    Process.sleep(2000)
  end

  defp receptor do
    receive do
      {:saludo, mensaje, emisor_pid} ->
        IO.puts("Receptor recibió: '#{mensaje}' de #{inspect(emisor_pid)}")
        # responder
        send(emisor_pid, {:respuesta, "Mensaje recibido 👍"})
        receptor()  # sigue esperando más mensajes
    after
      3000 ->
        IO.puts("Receptor: tiempo de espera agotado, me cierro")
    end
  end

  defp emisor(receptor_pid, 0) do
    IO.puts("Emisor terminó")
  end

  defp emisor(receptor_pid, veces) do
    send(receptor_pid, {:saludo, "Hola desde emisor", self()})

    receive do
      {:respuesta, respuesta} ->
        IO.puts("Emisor recibió respuesta: '#{respuesta}'")
    end

    Process.sleep(500)
    emisor(receptor_pid, veces - 1)
  end
end

Mensajes.main()
