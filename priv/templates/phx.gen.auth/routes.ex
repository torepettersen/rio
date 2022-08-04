  ## Authentication routes

  scope <%= router_scope %> do
    pipe_through [:browser, :redirect_if_<%= schema.singular %>_is_authenticated]

    live "/registration", <%= inspect schema.alias %>RegistrationLive
    post "/registration", <%= inspect schema.alias %>RegistrationController, :create

    live "/sign-in", <%= inspect schema.alias %>SessionLive
    post "/sign-in", <%= inspect schema.alias %>SessionController, :create

    live "/reset-password", <%= inspect schema.alias %>ResetPasswordLive, :new

    live "/reset-password/:token", <%= inspect schema.alias %>ResetPasswordLive, :edit
  end

  scope <%= router_scope %> do
    pipe_through [:browser]

    delete "/sign-out", <%= inspect schema.alias %>SessionController, :delete
  end
