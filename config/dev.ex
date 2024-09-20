# Configure your database
config :myapp, MyApp.Repo,
  username: "postgres",
  password: "postgres",
  database: "mydb",
  hostname: "localhost",
  port: 5433,
  show_sensitive_data_on_connection_error: true,
  pool_size: 5,
  log: false
