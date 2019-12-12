defmodule PostitWeb.AccountsControllerTest do
  use PostitWeb.ConnCase

  alias Postit.UserManager

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:accounts) do
    {:ok, accounts} = UserManager.create_accounts(@create_attrs)
    accounts
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.accounts_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Accounts"
    end
  end

  describe "new accounts" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.accounts_path(conn, :new))
      assert html_response(conn, 200) =~ "New Accounts"
    end
  end

  describe "create accounts" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.accounts_path(conn, :create), accounts: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.accounts_path(conn, :show, id)

      conn = get(conn, Routes.accounts_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Accounts"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.accounts_path(conn, :create), accounts: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Accounts"
    end
  end

  describe "edit accounts" do
    setup [:create_accounts]

    test "renders form for editing chosen accounts", %{conn: conn, accounts: accounts} do
      conn = get(conn, Routes.accounts_path(conn, :edit, accounts))
      assert html_response(conn, 200) =~ "Edit Accounts"
    end
  end

  describe "update accounts" do
    setup [:create_accounts]

    test "redirects when data is valid", %{conn: conn, accounts: accounts} do
      conn = put(conn, Routes.accounts_path(conn, :update, accounts), accounts: @update_attrs)
      assert redirected_to(conn) == Routes.accounts_path(conn, :show, accounts)

      conn = get(conn, Routes.accounts_path(conn, :show, accounts))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, accounts: accounts} do
      conn = put(conn, Routes.accounts_path(conn, :update, accounts), accounts: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Accounts"
    end
  end

  describe "delete accounts" do
    setup [:create_accounts]

    test "deletes chosen accounts", %{conn: conn, accounts: accounts} do
      conn = delete(conn, Routes.accounts_path(conn, :delete, accounts))
      assert redirected_to(conn) == Routes.accounts_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.accounts_path(conn, :show, accounts))
      end
    end
  end

  defp create_accounts(_) do
    accounts = fixture(:accounts)
    {:ok, accounts: accounts}
  end
end
