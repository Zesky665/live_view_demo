defmodule LiveViewDemoWeb.HaikuLive.Index do
    use Phoenix.LiveView
    use Phoenix.HTML
  
    alias LiveViewDemoWeb.HaikuView
    alias LiveViewDemo.Router.Helpers, as: Routes
    alias LiveViewDemo.Poems
    alias LiveViewDemo.Poems.Haiku
    alias Phoenix.LiveView.Socket
  
    @tick 10000

    def render(assigns) do
      ~L"""
      <style>
      @keyframes fade-out {
        
        40%, 100% {
          opacity: 0;
          transform: translate(300px, 0);
        }
        0% {
          opacity: 0;
        }
        40% {
          opacity: 1;
        }
        60% {
          opacity: 1;
        }
        
      }
      </style>
      <%= @tick %>
      <div style="
      animation: fade-out 10s infinite;">
      <h2>Your Haiku</h2>
      <p>
        <%= @haiku.line_one %>
        </br>
        <%= @haiku.line_two %>
        </br>
        <%= @haiku.line_three %>
        </br>
        <p>- <%= @haiku.author %> </p>
      </p>
      </div>
      """
    end
  
    def mount(_session, socket) do
      {:ok, assign(socket, haiku: Poems.get_random_haiku(), tick: @tick, current: 0) |> schedule_tick }
    end
  
    defp fetch(%Socket{} = socket) do
      assign(socket, haiku: Poems.get_random_haiku())
    end

    def handle_info(:tick, socket) do
        new_socket =
          socket
          |> fetch()
          |> schedule_tick()
    
        {:noreply, new_socket}
    end

    defp schedule_tick(socket) do
        Process.send_after(self(), :tick, socket.assigns.tick)
        socket
    end
  end