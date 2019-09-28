defmodule LiveViewDemo.PoemsTest do
  use LiveViewDemo.DataCase

  alias LiveViewDemo.Poems

  describe "haiku" do
    alias LiveViewDemo.Poems.Haiku

    @valid_attrs %{_: "some _", line_one: "some line_one", line_three: "some line_three", line_two: "some line_two"}
    @update_attrs %{_: "some updated _", line_one: "some updated line_one", line_three: "some updated line_three", line_two: "some updated line_two"}
    @invalid_attrs %{_: nil, line_one: nil, line_three: nil, line_two: nil}

    def haiku_fixture(attrs \\ %{}) do
      {:ok, haiku} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Poems.create_haiku()

      haiku
    end

    test "list_haiku/0 returns all haiku" do
      haiku = haiku_fixture()
      assert Poems.list_haiku() == [haiku]
    end

    test "get_haiku!/1 returns the haiku with given id" do
      haiku = haiku_fixture()
      assert Poems.get_haiku!(haiku.id) == haiku
    end

    test "create_haiku/1 with valid data creates a haiku" do
      assert {:ok, %Haiku{} = haiku} = Poems.create_haiku(@valid_attrs)
      assert haiku._ == "some _"
      assert haiku.line_one == "some line_one"
      assert haiku.line_three == "some line_three"
      assert haiku.line_two == "some line_two"
    end

    test "create_haiku/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Poems.create_haiku(@invalid_attrs)
    end

    test "update_haiku/2 with valid data updates the haiku" do
      haiku = haiku_fixture()
      assert {:ok, %Haiku{} = haiku} = Poems.update_haiku(haiku, @update_attrs)
      assert haiku._ == "some updated _"
      assert haiku.line_one == "some updated line_one"
      assert haiku.line_three == "some updated line_three"
      assert haiku.line_two == "some updated line_two"
    end

    test "update_haiku/2 with invalid data returns error changeset" do
      haiku = haiku_fixture()
      assert {:error, %Ecto.Changeset{}} = Poems.update_haiku(haiku, @invalid_attrs)
      assert haiku == Poems.get_haiku!(haiku.id)
    end

    test "delete_haiku/1 deletes the haiku" do
      haiku = haiku_fixture()
      assert {:ok, %Haiku{}} = Poems.delete_haiku(haiku)
      assert_raise Ecto.NoResultsError, fn -> Poems.get_haiku!(haiku.id) end
    end

    test "change_haiku/1 returns a haiku changeset" do
      haiku = haiku_fixture()
      assert %Ecto.Changeset{} = Poems.change_haiku(haiku)
    end
  end
end
