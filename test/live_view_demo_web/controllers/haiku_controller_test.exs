defmodule LiveViewDemoWeb.HaikuControllerTest do
  use LiveViewDemoWeb.ConnCase

  alias LiveViewDemo.Poems

  @create_attrs %{_: "some _", line_one: "some line_one", line_three: "some line_three", line_two: "some line_two"}
  @update_attrs %{_: "some updated _", line_one: "some updated line_one", line_three: "some updated line_three", line_two: "some updated line_two"}
  @invalid_attrs %{_: nil, line_one: nil, line_three: nil, line_two: nil}

  def fixture(:haiku) do
    {:ok, haiku} = Poems.create_haiku(@create_attrs)
    haiku
  end

  describe "index" do
    test "lists all haiku", %{conn: conn} do
      conn = get(conn, Routes.haiku_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Haiku"
    end
  end

  describe "new haiku" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.haiku_path(conn, :new))
      assert html_response(conn, 200) =~ "New Haiku"
    end
  end

  describe "create haiku" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.haiku_path(conn, :create), haiku: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.haiku_path(conn, :show, id)

      conn = get(conn, Routes.haiku_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Haiku"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.haiku_path(conn, :create), haiku: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Haiku"
    end
  end

  describe "edit haiku" do
    setup [:create_haiku]

    test "renders form for editing chosen haiku", %{conn: conn, haiku: haiku} do
      conn = get(conn, Routes.haiku_path(conn, :edit, haiku))
      assert html_response(conn, 200) =~ "Edit Haiku"
    end
  end

  describe "update haiku" do
    setup [:create_haiku]

    test "redirects when data is valid", %{conn: conn, haiku: haiku} do
      conn = put(conn, Routes.haiku_path(conn, :update, haiku), haiku: @update_attrs)
      assert redirected_to(conn) == Routes.haiku_path(conn, :show, haiku)

      conn = get(conn, Routes.haiku_path(conn, :show, haiku))
      assert html_response(conn, 200) =~ "some updated _"
    end

    test "renders errors when data is invalid", %{conn: conn, haiku: haiku} do
      conn = put(conn, Routes.haiku_path(conn, :update, haiku), haiku: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Haiku"
    end
  end

  describe "delete haiku" do
    setup [:create_haiku]

    test "deletes chosen haiku", %{conn: conn, haiku: haiku} do
      conn = delete(conn, Routes.haiku_path(conn, :delete, haiku))
      assert redirected_to(conn) == Routes.haiku_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.haiku_path(conn, :show, haiku))
      end
    end
  end

  defp create_haiku(_) do
    haiku = fixture(:haiku)
    {:ok, haiku: haiku}
  end
end
