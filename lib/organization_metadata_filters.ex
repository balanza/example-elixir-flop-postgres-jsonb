defmodule MyApp.Utility.MetadataFilter do
  
  import Ecto.Query

  def metadata(query, %Flop.Filter{field: name, value: value, op: op} = _flop_filter, _) do
    IO.puts("----->MetadataFilter.metadata")
    metadata_value = value(name, value)

    expr = dynamic_expr(name)

    case metadata_value do
      {:ok, query_value} ->
        conditions =
          case op do
            :== -> dynamic([r], ^expr == ^query_value)
            :!= -> dynamic([r], ^expr != ^query_value)
            :> -> dynamic([r], ^expr > ^query_value)
            :< -> dynamic([r], ^expr < ^query_value)
            :>= -> dynamic([r], ^expr >= ^query_value)
            :<= -> dynamic([r], ^expr <= ^query_value)
          end

        where(query, ^conditions)

      :error ->
        IO.inspect("Error casting value #{value} for #{name}")
        query
    end
  end

  def field(:metadata_active), do: :active
  def field(:metadata_owner), do: :owner

  def value(:metadata_active, value), do: Ecto.Type.cast(:boolean, value)
  def value(:metadata_owner, value), do: Ecto.Type.cast(:string, value)

  def dynamic_expr(:metadata_active) do
    dynamic(
      [r],
      fragment(
        "(?->>'active')::boolean",
        field(r, :metadata)
      )
    )
  end

  def dynamic_expr(:metadata_owner) do
    dynamic(
      [r],
      fragment(
        "(?->>'owner')",
        field(r, :metadata)
      )
    )
  end
end
