Sequel.migration {
  change do
    alter_table(:users) do
    add_column :admin, TrueClass
  end
end
}