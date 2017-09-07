defmodule Chatter.UserTest do
  use Chatter.ModelCase

  alias Chatter.User

  @valid_attrs %{email: "some email", encrypt_pass: "some encrypt_pass"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
