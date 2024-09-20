defmodule MyApp do
  alias MyApp.Organization

  def exec do
    params = %{filters: [%{value: "anyvalue", op: "==", field: :metadata_owner}]}

    parsed_filters = Flop.validate!(params, for: Organization)
    IO.puts("----->Parsed filters:")
    IO.inspect(parsed_filters)
    query = Flop.query(Organization, parsed_filters)
    IO.puts("----->Generated query:")
    IO.inspect(query)
  end
end
