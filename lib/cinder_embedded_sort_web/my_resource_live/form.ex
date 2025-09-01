defmodule CinderEmbeddedSortWeb.MyResourceLive.Form do
  use CinderEmbeddedSortWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage my_resource records in your database.</:subtitle>
      </.header>

      <.form
        for={@form}
        id="my_resource-form"
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />

        <.inputs_for :let={p_form} field={@form[:params]}>
          <.input field={p_form[:a]} type="text" label="A" />
          <.input field={p_form[:b]} type="text" label="B" />
        </.inputs_for>

        <.button phx-disable-with="Saving..." variant="primary">Save My resource</.button>
        <.button navigate={return_path(@return_to, @my_resource)}>Cancel</.button>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    my_resource =
      case params["id"] do
        nil -> nil
        id -> Ash.get!(CinderEmbeddedSort.MyDomain.MyResource, id)
      end

    action = if is_nil(my_resource), do: "New", else: "Edit"
    page_title = action <> " " <> "My resource"

    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> assign(my_resource: my_resource)
     |> assign(:page_title, page_title)
     |> assign_form()}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  @impl true
  def handle_event("validate", %{"my_resource" => my_resource_params}, socket) do
    {:noreply,
     assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, my_resource_params))}
  end

  def handle_event("save", %{"my_resource" => my_resource_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: my_resource_params) do
      {:ok, my_resource} ->
        notify_parent({:saved, my_resource})

        socket =
          socket
          |> put_flash(:info, "My resource #{socket.assigns.form.source.type}d successfully")
          |> push_navigate(to: return_path(socket.assigns.return_to, my_resource))

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp assign_form(%{assigns: %{my_resource: my_resource}} = socket) do
    form =
      if my_resource do
        AshPhoenix.Form.for_update(my_resource, :update, as: "my_resource")
        |> AshPhoenix.Form.add_form(:settings)
      else
        AshPhoenix.Form.for_create(CinderEmbeddedSort.MyDomain.MyResource, :create,
          as: "my_resource"
        )
        |> AshPhoenix.Form.add_form(:settings)
      end

    assign(socket, form: to_form(form))
  end

  defp return_path("index", _my_resource), do: ~p"/my_resources"
  defp return_path("show", my_resource), do: ~p"/my_resources/#{my_resource.id}"
end
