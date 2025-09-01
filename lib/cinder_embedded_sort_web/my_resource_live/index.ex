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

      <Cinder.Table.table resource={CinderEmbeddedSort.MyDomain.MyResource}>
        <:col :let={r} field="name" filter sort>{r.name}</:col>
        <:col :let={r} field="settings__a" filter sort>{r.settings.a}</:col>
        <:col :let={r} field="settings__b" filter sort>{r.settings.b}</:col>
      </Cinder.Table.table>
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
