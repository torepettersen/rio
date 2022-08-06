defmodule <%= context.base_module %>.Factory do
  use ExMachina.Ecto, repo: <%= context.base_module %>.Repo

  alias <%= schema.module %> 

  def valid_<%= schema.singular %>__password, do: "hello world!"

  def <%= schema.singular %>_factory do
    %<%= schema.alias %>{
      email: sequence(:email, &"<%= schema.singular %>#{&1}@example.com"),
      hashed_password: Argon2.hash_pwd_salt(valid_<%= schema.singular %>_password())
    }
  end
end
