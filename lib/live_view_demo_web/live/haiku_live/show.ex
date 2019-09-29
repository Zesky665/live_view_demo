defmodule LiveViewDemoWeb.HaikuLive.Show do
    use Phoenix.LiveView
    use Phoenix.HTML
  
    alias LiveViewDemoWeb.HaikuView
    alias LiveViewDemoWeb.Router.Helpers, as: Routes
    alias LiveViewDemo.Poems
    alias LiveViewDemo.Poems.Haiku
    alias Phoenix.LiveView.Socket
  
    def render(assigns) do
      ~L"""
      <h2>Your Haiku</h2>
      <p>
        <%= @haiku.line_one %>
        </br>
        <%= @haiku.line_two %>
        </br>
        <%= @haiku.line_three %>
        </br>
        <p>- <%= @haiku.author %></p>
      </p>
      </br>
      <span><%= live_link "Go back to homepage", to: Routes.live_path(@socket, LiveViewDemoWeb.HaikuLive.Index) %></span>
      """
    end
  
    def mount(%{path_params: %{"id" => id}}, socket) do
      if connected?(socket), do: LiveViewDemo.Poems.subscribe(id)
      {:ok, fetch(assign(socket, id: id))}
    end
  
    defp fetch(%Socket{assigns: %{id: id}} = socket) do
      assign(socket, haiku: Poems.get_haiku!(id))
    end
  end