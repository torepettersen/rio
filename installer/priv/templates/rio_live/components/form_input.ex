defmodule <%= @web_namespace %>.FormInputComponent do
  use <%= @web_namespace %>, :component

  def form_input(assigns) do
    ~H"""
    <div class="space-y-1">
      <.form_label {assigns} />
      <.input {assigns} />
      <%%= error_tag @form, @field %>
    </div>
    """
  end

  defp form_label(assigns) do
    ~H"""
    <%%= label @form, @field, class: "block text-sm font-medium text-gray-700" %>
    """
  end

  defp input(%{type: :email} = assigns) do
    ~H"""
    <%%= email_input @form, @field, class: input_style(), required: true %>
    """
  end

  defp input(%{type: :password} = assigns) do
    ~H"""
    <%%= password_input @form, @field, class: input_style(), required: true %>
    """
  end

  defp input_style do
    "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
  end
end
