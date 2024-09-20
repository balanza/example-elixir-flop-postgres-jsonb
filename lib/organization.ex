defmodule MyApp.Organization do
  use Ecto.Schema

  alias MyApp.Utility.MetadataFilter

  @type t() :: %__MODULE__{}

  @derive {
    Flop.Schema,
    filterable: [:name, :whatsapp_no, :metadata_active, :metadata_owner],
    sortable: [:name, :whatsapp_no],
    max_limit: 100,
    default_limit: 50,
    adapter_opts: [
      custom_fields: [
        metadata_active: [
          filter: {MetadataFilter, :metadata, []},
          ecto_type: :boolean
        ],
        metadata_owner: [
          filter: {MetadataFilter, :metadata, []},
          ecto_type: :string
        ]
      ]
    ]
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "organizations" do
    field(:name, :string)
    field(:whatsapp_no, :string)

    embeds_one :metadata, OrganizationMetadata do
      field(:owner, :string)
      field(:active, :boolean)
    end
  end
end
