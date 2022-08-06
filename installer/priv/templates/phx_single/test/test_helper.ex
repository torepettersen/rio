ExUnit.start()<%= if @ecto do %>
<%= @adapter_config[:test_setup_all] %><% end %>

{:ok, _} = Application.ensure_all_started(:ex_machina)
