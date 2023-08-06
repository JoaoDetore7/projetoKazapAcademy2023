module History_account
    def self.show_last_statements(account_id)
        last_upgrades = History.where(account_id: account_id).order(Sequel.desc(:created_at)).limit(5)

        export = last_upgrades.each do |upgrade|
            puts "ID da transação: #{upgrade.id}"
            puts "ID da conta: #{upgrade.account_id}"
            puts "Valor: #{upgrade.amount}"
            puts "Descrição: #{upgrade.description}"
            puts "Criado em: #{upgrade.created_at}"
            puts "------------------------------------"
        end
    end

    def self.export_history(account_id)
        last_upgrades = History.where(account_id: account_id).order(Sequel.desc(:created_at)).limit(5)

        historys = []
        last_upgrades.each do |upgrade|
            historys << {
            upgrade_id: upgrade.id,
            account_id: upgrade.account_id,
            amount: upgrade.amount,
            description: upgrade.description,
            created_at: upgrade.created_at
        }
        end
        p historys
        File.open("assets/history/#{account_id} - history", 'w') do |file|
                file.puts JSON.pretty_generate(historys)
        end

        puts Rainbow("Generate success, avaliable on assets - history").green
    end
end