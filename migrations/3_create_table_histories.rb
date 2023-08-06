require 'sequel'

Sequel.migration do
    change do
      create_table(:histories) do
        primary_key :id
        foreign_key :account_id, :accounts
        Float :amount
        String :description
        DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
      end
    end
  end