defmodule LiveViewDemo.Poems.Haiku do
  @moduledoc """
  The Haiku schema. 
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "haiku" do
    field :line_one, :string
    field :line_three, :string
    field :line_two, :string
    field :author, :string

    timestamps()
  end

  @syllable_regex ~r/[AaEeIiOoUuYy]{1,2}/

  @doc """
  Returns the number of syllables in a string. 

  ## Examples

      iex> count_syllables("Test")
      1

  """
  
  defp count_syllables(string) do
    cleaned_string = Regex.replace(~r/[e]+[ ]|e$/, string, " ")
    Regex.scan(@syllable_regex, cleaned_string) |> Enum.count
  end

  defp validate_syllables(changeset, field, value) do 

    validate_change(changeset, field, fn (current_field, field_value) ->
      if count_syllables(field_value) === value do
        []
      else 
        [{field, "has #{count_syllables(field_value)} syllables, needs #{value}"}]
      end
    end)
  end

  @doc false
  def changeset(haiku, attrs) do
    haiku
    |> cast(attrs, [:line_one, :line_two, :line_three, :author])
    |> validate_required([:line_one, :line_two, :line_three, :author])
    |> validate_syllables(:line_one, 5)
    |> validate_syllables(:line_two, 7)
    |> validate_syllables(:line_three, 5)
  end
end
