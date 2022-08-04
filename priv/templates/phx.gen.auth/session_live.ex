defmodule <%= inspect context.web_module %>.<%= inspect web_module_prefix %>SessionLive do
  use <%= inspect context.web_module %>, :live_view

  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>RegistrationLive

  def mount(_params, session, socket) do
    socket = assign(socket, error_message: session["error_message"])
    {:ok, socket}
  end
end
