defmodule EachShareWeb.Router do
  use EachShareWeb, :router

  pipeline :api do
    #plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", EachShareWeb do
    pipe_through :api
    post "/upload-file", FileController, :upload_file
    post "/associate-folder", FolderController, :associate_folder
    post "/associate-file", FolderController, :associate_file
    resources "/folders", FolderController, [:index, :create, :update, :show]
  end
end
