defmodule CinderEmbeddedSortWeb.MyResourceLive.Show do
  use CinderEmbeddedSortWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        My resource {@my_resource.id}
        <:subtitle>This is a my_resource record from your database.</:subtitle>

        <:actions>
          <.button navigate={~p"/my_resources"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/my_resources/#{@my_resource}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit My resource
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Id">{@my_resource.id}</:item>

        <:item title="Name">{@my_resource.name}</:item>

        <:item title="Settings">{@my_resource.settings}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show My resource")
     |> assign(:my_resource, Ash.get!(CinderEmbeddedSort.MyDomain.MyResource, id))}
  end
end
