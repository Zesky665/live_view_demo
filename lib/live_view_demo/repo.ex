defmodule LiveViewDemo.Repo do
  use Ecto.Repo,
    otp_app: :live_view_demo,
    adapter: Ecto.Adapters.Postgres,
    pool_size: 10

    def init(_type, config) do
      {:ok, Keyword.put(config, :url, System.get_env("DATABSE_URL"))}
    end  
end
