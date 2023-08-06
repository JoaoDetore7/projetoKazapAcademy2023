require 'sequel'

Sequel.migration do
  change do 
        create_table :accounts do
            primary_key :id
            Float :balance, default: 0.0
            Float :credit_limit, default: -100.0
            Float :credit_balance, default: 0.0
            foreign_key :user_id, :users
        end
    end
end