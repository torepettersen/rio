defmodule <%= inspect context.web_module %>.<%= inspect web_module_prefix %>ResetPasswordView do
  use <%= inspect context.web_module %>, :view

  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>SessionLive
  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>RegistrationLive
end
