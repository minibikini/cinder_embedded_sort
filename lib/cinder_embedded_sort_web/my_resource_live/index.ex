defmodule CinderEmbeddedSortWeb.MyResourceLive.Index do
  use CinderEmbeddedSortWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing My resources
        <:actions>
          <.button variant="primary" navigate={~p"/my_resources/new"}>
            <.icon name="hero-plus" /> New My resource
          </.button>
        </:actions>
      </.header>

      <.table
        id="my_resources"
        rows={@streams.my_resources}
        row_click={fn {_id, my_resource} -> JS.navigate(~p"/my_resources/#{my_resource}") end}
      >
        <:col :let={{_id, my_resource}} label="Id">{my_resource.id}</:col>

        <:col :let={{_id, my_resource}} label="Name">{my_resource.name}</:col>

        <:col :let={{_id, my_resource}} label="Settings">{my_resource.settings}</:col>

        <:action :let={{_id, my_resource}}>
          <div class="sr-only">
            <.link navigate={~p"/my_resources/#{my_resource}"}>Show</.link>
          </div>

          <.link navigate={~p"/my_resources/#{my_resource}/edit"}>Edit</.link>
        </:action>

        <:action :let={{id, my_resource}}>
          <.link
            phx-click={JS.push("delete", value: %{id: my_resource.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing My resources")
     |> stream(:my_resources, Ash.read!(CinderEmbeddedSort.MyDomain.MyResource))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    my_resource = Ash.get!(CinderEmbeddedSort.MyDomain.MyResource, id)
    Ash.destroy!(my_resource)

    {:noreply, stream_delete(socket, :my_resources, my_resource)}
  end
end
