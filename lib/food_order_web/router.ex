defmodule FoodOrderWeb.Router do
  use FoodOrderWeb, :router

  host =
    :food_order
    |> Application.fetch_env!(FoodOrderWeb.Endpoint)
    |> Keyword.fetch!(:url)
    |> Keyword.fetch!(:host)

  @content_security_policy (case Mix.env() do
                              :prod ->
                                "default-src 'self';connect-src wss://#{host};img-src 'self' blob:;"

                              _ ->
                                "default-src 'self' 'unsafe-eval' 'unsafe-inline';" <>
                                  "connect-src ws://#{host}:*;" <>
                                  "img-src 'self' blob: data:;" <>
                                  "font-src 'self' data:;"
                            end)

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FoodOrderWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"content-security-policy" => @content_security_policy}
  end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  scope "/", FoodOrderWeb do
    pipe_through :browser

    live "/", MainLive, :index

    scope "/admin", Admin, as: :admin do
      live "/products", ProductLive, :index
      live "/products/new", ProductLive, :new
      live "/products/:id/edit", ProductLive, :edit

    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", FoodOrderWeb do
  #   pipe_through :api
  # end

  # coveralls-ignore-start
  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FoodOrderWeb.Telemetry
    end
  end

  # coveralls-ignore-stop

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
