defmodule LiveViewDemo.Poems do
  @moduledoc """
  The Poems context.
  """

  import Ecto.Query, warn: false
  alias LiveViewDemo.Repo

  alias LiveViewDemo.Poems.Haiku

  @doc """
  Returns the list of haiku.

  ## Examples

      iex> list_haiku()
      [%Haiku{}, ...]

  """
  def list_haiku do
    Repo.all(Haiku)
  end


  def get_haikus() do
    query = from h in Haiku, 
    order_by: [asc: :id],
    limit: 3

    Repo.all(query)
  end

  def get_random_haiku do
    query = from h in Haiku, 
    order_by: fragment("RANDOM()"),
    limit: 1

    test = Repo.all(query)

    Enum.at(test, 0)
  end


  @doc """
  Gets a single haiku.

  Raises `Ecto.NoResultsError` if the Haiku does not exist.

  ## Examples

      iex> get_haiku!(123)
      %Haiku{}

      iex> get_haiku!(456)
      ** (Ecto.NoResultsError)

  """
  def get_haiku!(id), do: Repo.get!(Haiku, id)

  @doc """
  Creates a haiku.

  ## Examples

      iex> create_haiku(%{field: value})
      {:ok, %Haiku{}}

      iex> create_haiku(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_haiku(attrs \\ %{}) do
    %Haiku{}
    |> Haiku.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a haiku.

  ## Examples

      iex> update_haiku(haiku, %{field: new_value})
      {:ok, %Haiku{}}

      iex> update_haiku(haiku, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_haiku(%Haiku{} = haiku, attrs) do
    haiku
    |> Haiku.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Haiku.

  ## Examples

      iex> delete_haiku(haiku)
      {:ok, %Haiku{}}

      iex> delete_haiku(haiku)
      {:error, %Ecto.Changeset{}}

  """
  def delete_haiku(%Haiku{} = haiku) do
    Repo.delete(haiku)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking haiku changes.

  ## Examples

      iex> change_haiku(haiku)
      %Ecto.Changeset{source: %Haiku{}}

  """
  def change_haiku(haiku, attrs \\ %{}) do
    Haiku.changeset(haiku, attrs)
  end
  @topic inspect(__MODULE__)
  def subscribe do
    Phoenix.PubSub.subscribe(LiveViewDemo.PubSub, @topic)
  end

  def subscribe(haiku_id) do
    Phoenix.PubSub.subscribe(LiveViewDemo.PubSub, @topic <> "#{haiku_id}")
  end
end
