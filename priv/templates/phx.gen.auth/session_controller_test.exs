defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>SessionControllerTest do
  use <%= inspect context.web_module %>.ConnCase<%= test_case_options %>

  import <%= inspect context.module %>Fixtures

  setup do
    %{<%= schema.singular %>: <%= schema.singular %>_fixture()}
  end

  describe "POST <%= web_path_prefix %>/sign-in" do
    test "logs the <%= schema.singular %> in", %{conn: conn, <%= schema.singular %>: <%= schema.singular %>} do
      conn =
        post(conn, Routes.<%= schema.route_helper %>_session_path(conn, :create), %{
          "<%= schema.singular %>" => %{"email" => <%= schema.singular %>.email, "password" => valid_<%= schema.singular %>_password()}
        })

      assert get_session(conn, :<%= schema.singular %>_token)
      assert redirected_to(conn) == "/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ "Sign out"
    end

    test "logs the <%= schema.singular %> in with remember me", %{conn: conn, <%= schema.singular %>: <%= schema.singular %>} do
      conn =
        post(conn, Routes.<%= schema.route_helper %>_session_path(conn, :create), %{
          "<%= schema.singular %>" => %{
            "email" => <%= schema.singular %>.email,
            "password" => valid_<%= schema.singular %>_password(),
            "remember_me" => "true"
          }
        })

      assert conn.resp_cookies["_<%= web_app_name %>_<%= schema.singular %>_remember_me"]
      assert redirected_to(conn) == "/"
    end

    test "logs the <%= schema.singular %> in with return to", %{conn: conn, <%= schema.singular %>: <%= schema.singular %>} do
      conn =
        conn
        |> init_test_session(<%= schema.singular %>_return_to: "/foo/bar")
        |> post(Routes.<%= schema.route_helper %>_session_path(conn, :create), %{
          "<%= schema.singular %>" => %{
            "email" => <%= schema.singular %>.email,
            "password" => valid_<%= schema.singular %>_password()
          }
        })

      assert redirected_to(conn) == "/foo/bar"
    end

    test "emits error message with invalid credentials", %{conn: conn, <%= schema.singular %>: <%= schema.singular %>} do
      conn =
        post(conn, Routes.<%= schema.route_helper %>_session_path(conn, :create), %{
          "<%= schema.singular %>" => %{"email" => <%= schema.singular %>.email, "password" => "invalid_password"}
        })

      response = html_response(conn, 200)
      assert response =~ "Sign in</h1>"
      assert response =~ "Invalid email or password"
    end
  end

  describe "DELETE <%= web_path_prefix %>/<%= schema.plural %>/log_out" do
    test "logs the <%= schema.singular %> out", %{conn: conn, <%= schema.singular %>: <%= schema.singular %>} do
      conn = conn |> log_in_<%= schema.singular %>(<%= schema.singular %>) |> delete(Routes.<%= schema.route_helper %>_session_path(conn, :delete))
      assert redirected_to(conn) == "/"
      refute get_session(conn, :<%= schema.singular %>_token)
      assert get_flash(conn, :info) =~ "Logged out successfully"
    end

    test "succeeds even if the <%= schema.singular %> is not logged in", %{conn: conn} do
      conn = delete(conn, Routes.<%= schema.route_helper %>_session_path(conn, :delete))
      assert redirected_to(conn) == "/"
      refute get_session(conn, :<%= schema.singular %>_token)
      assert get_flash(conn, :info) =~ "Logged out successfully"
    end
  end
end
