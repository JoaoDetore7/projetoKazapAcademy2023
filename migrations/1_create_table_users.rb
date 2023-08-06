require 'sequel'

Sequel.migration do
  change do 
        create_table :users do
            primary_key :id
            String :name
            String :document
            String :address
            String :phone
        end
    end
end