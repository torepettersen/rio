defmodule <%= inspect context.base_module %>.Factory do
  use ExMachina.Ecto, repo: <%= inspect context.base_module %>.Repo

  alias <%= inspect schema.module %>

  def valid_<%= schema.singular %>_password, do: "hello world!"

  def user_factory do
    %<%= inspect schema.alias %>{
      email: sequence(:email, &"<%= schema.singular %>#{&1}@example.com"),
      hashed_password: Argon2.hash_pwd_salt(valid_<%= schema.singular %>_password())
    }
  end
end
