defmodule LiveViewDemoWeb.HaikuController do
  use LiveViewDemoWeb, :controller

  alias LiveViewDemo.Poems
  alias LiveViewDemo.Poems.Haiku

  def index(conn, _params) do
    haiku = Poems.list_haiku()
    render(conn, "index.html", haiku: haiku)
  end

  def new(conn, _params) do
    changeset = Poems.change_haiku(%Haiku{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"haiku" => haiku_params}) do
    case Poems.create_haiku(haiku_params) do
      {:ok, haiku} ->
        conn
        |> put_flash(:info, "Haiku created successfully.")
        |> redirect(to: Routes.haiku_path(conn, :show, haiku))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    haiku = Poems.get_haiku!(id)
    render(conn, "show.html", haiku: haiku)
  end

  def edit(conn, %{"id" => id}) do
    haiku = Poems.get_haiku!(id)
    changeset = Poems.change_haiku(haiku)
    render(conn, "edit.html", haiku: haiku, changeset: changeset)
  end

  def update(conn, %{"id" => id, "haiku" => haiku_params}) do
    haiku = Poems.get_haiku!(id)

    case Poems.update_haiku(haiku, haiku_params) do
      {:ok, haiku} ->
        conn
        |> put_flash(:info, "Haiku updated successfully.")
        |> redirect(to: Routes.haiku_path(conn, :show, haiku))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", haiku: haiku, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    haiku = Poems.get_haiku!(id)
    {:ok, _haiku} = Poems.delete_haiku(haiku)

    conn
    |> put_flash(:info, "Haiku deleted successfully.")
    |> redirect(to: Routes.haiku_path(conn, :index))
  end
end
