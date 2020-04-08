defmodule Rumbl.Accounts.UserTest do
  use Rumbl.DataCase, async: true

  alias Rumbl.Accounts.User
  alias Rumbl.Accounts

  @valid_attrs %{name: "A User", username: "eva", password: "secret"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset does not accept long usernames" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
    {:error, changeset} = Accounts.register_user(attrs)

    assert %{username: ["should be at most 20 character(s)"]} = errors_on(changeset)

    assert Accounts.list_users() == []
  end

  test "requires password to be at least 6 chars long" do
    attrs = Map.put(@valid_attrs, :password, "12345")
    {:error, changeset} = Accounts.register_user(attrs)

    assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)

    assert Accounts.list_users() == []
  end
end
