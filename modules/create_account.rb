module Create_account

    def self.create_new_account(user_id)
        user = User.where(id: user_id).first
        new_account = Account.new(user_id: user.id)
        user.add_account(new_account)
        puts Rainbow("Account created, id: #{new_account.id}").green
    end

    def create_json(user_id)
        user = User.where(id: user_id).first
        File.open("#{user.id}history", 'w') do |file|
            file.puts JSON.pretty_generate()
        end
    end

    def update_json(user_id, transaction_type, date)
        user = User.where(id: user_id).first
        transaction_id = UUID.generate
        transactions = {
            transaction_type: transaction_type,
            transaction_id: transaction_id,
        }

        File.open("#{account.id} - history", 'w') do |file|
            file.puts JSON.pretty_generate(transactions)
        end
    end
end