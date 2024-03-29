defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>RegistrationControllerTest do
  use <%= inspect context.web_module %>.ConnCase<%= test_case_options %>

  describe "POST <%= web_path_prefix %>/registration" do
    @tag :capture_log
    test "creates account and logs the <%= schema.singular %> in", %{conn: conn} do
      conn =
        post(conn, Routes.<%= schema.route_helper %>_registration_path(conn, :create), %{
          "<%= schema.singular %>" => params_for(:<%= schema.singular %>, password: valid_<%= schema.singular %>_password())
        })

      assert get_session(conn, :<%= schema.singular %>_token)
      assert redirected_to(conn) == "/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ "Sign out"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.<%= schema.route_helper %>_registration_path(conn, :create), %{
          "<%= schema.singular %>" => %{"email" => "with spaces", "password" => "too short"}
        })

      response = html_response(conn, 200)
      assert response =~ "Register</h1>"
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "should be at least 12 character"
    end
  end
end
