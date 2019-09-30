defmodule LiveViewDemoWeb.HaikuLive.New do
  @moduledoc """
  The New live page. Haiku are validated in real time here. 
  """
  use Phoenix.LiveView
  import Calendar.Strftime

  alias LiveViewDemoWeb.HaikuView
  alias LiveViewDemoWeb.Router.Helpers, as: Routes
  alias LiveViewDemo.Poems
  alias LiveViewDemo.Poems.Haiku

  def mount(_session, socket) do
    changeset = Poems.change_haiku(%Haiku{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(LiveViewDemoWeb.HaikuView, "new.html", assigns)

  def handle_event("validate", %{"haiku" => haiku_params} = params, socket) do
    changeset =
      %Haiku{}
      |> LiveViewDemo.Poems.change_haiku(haiku_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"haiku" => haiku_params} = params, socket) do
    case Poems.create_haiku(haiku_params) do
      {:ok, haiku} ->
        {:stop,
         socket
         |> put_flash(:info, "haiku created")
         |> redirect(to: Routes.live_path(socket, LiveViewDemoWeb.HaikuLive.Show, haiku.id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
