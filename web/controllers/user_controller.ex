defmodule Chatter.UserController do
    use Chatter.Web, :controller
    alias Chatter.User

    def index(conn, _params) do
        users = Repo.all(User)
        render(conn, "index.html", users: users)
    end

    def show(conn, %{"id" => id})do
        user = Repo.get!(User, id)
        render(conn, "show.html", user: user)
    end

    def new(conn, _params) do
        changeset = User.changeset(%User{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"user" => user_params}) do
        changeset = User.reg_changeset(%User{}, user_params)

        case Repo.insert(changeset) do 
            {:ok, _user} -> 
                conn
                |> put_flash(:info, "User created successfully.")
                |> redirect(to: user_path(conn, :index))
            {:error, changeset} -> 
                render(conn, "new.html", changeset: changeset)
        end
    end

    def edit(conn, %{"id" => id}) do
        user = Repo.get!(User, id)
        changeset = User.changeset(user)
        render(conn, "edit.html", user: user, changeset: changeset)
    end

    def update(conn, %{"id" => id, "user" => user_params}) do
        user = Repo.get!(User, id)
        changeset = User.reg_changeset(user, user_params)

        case Repo.update(changeset) do 
            {:ok, user} -> 
                conn
                |> put_flash(:info, "User updated successfully.")
                |> redirect(to: user_path(conn, :show, user))
            {:error, changeset} -> 
                render(conn, "edit.html", user: user, changeset: changeset)
        end
    end

    def delete(conn, %{"id" => id}) do
        user = Repo.get!(User, id)
        Repo.delete!(user)

        conn
        |> put_flash(:danger, "User deleted successfully.")
        |> redirect(to: user_path(conn, :index))
    end
end