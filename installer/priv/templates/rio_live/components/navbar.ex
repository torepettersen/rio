defmodule <%= @web_namespace %>.Components.Navbar do
  use <%= @web_namespace %>, :component

  def navbar(assigns) do
    ~H"""
    <header class="py-10">
      <.container>
        <nav class="relative z-50 flex justify-between">
          <div class="flex items-center md:gap-x-12">
            <.link href="/" class="text-xl text-bold">
              Rio<span class="text-blue-600">Generator</span>
            </.link>
            <div class="hidden md:flex md:gap-x-6">
              <.nav_link href="https://hexdocs.pm/phoenix/overview.html">Phoenix</.nav_link>
              <.nav_link href="https://tailwindcss.com/">Tailwind CSS</.nav_link>
              <.nav_link href="https://tailwindui.com/">Tailwind UI</.nav_link>
              <%%= if function_exported?(Routes, :live_dashboard_path, 2) do %>
                <.nav_link href={Routes.live_dashboard_path(<%= @web_namespace %>.Endpoint, :home)}>Live dashboard</.nav_link>
              <%% end %>
            </div>
          </div>
          <div class="flex items-center gap-x-5 md:gap-x-8">
            <div class="hidden md:block">
              <.nav_link href="/users/log_in">Sign in</.nav_link>
            </div>
            <.button href="/users/register">Register</.button>
          </div>
        </nav>
      </.container>
    </header>
    """
  end

  defp nav_link(assigns) do
    ~H"""
    <.link href={@href} class="inline-block rounded-lg py-1 px-2 text-sm text-slate-700 hover:bg-slate-100 hover:text-slate-900">
      <%%= render_slot(@inner_block) %>
    </.link>
    """
  end
end
