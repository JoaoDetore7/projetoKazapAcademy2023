require_relative 'history_account'

module Aplication
    def self.deposit(account_id, amount)
        account = Account.where(id: account_id).first
        if account.credit_balance < 0 
            new_amount = amount + account.credit_balance
            account.credit_balance += amount
            if account.credit_balance >= 0  
                account.credit_balance = 0
                account.balance += new_amount
                account.save
            end
        else
          account.balance += amount
          account.save
        end
        new_upgrade(account, amount, 'deposit')
        available_balance(account_id)
      end
    
      def self.withdraw(account_id, amount)
        account = Account.where(id: account_id).first
        if account.balance >= amount
          account.balance -= amount
          account.save
        elsif (account.balance - amount) >= account.credit_limit
          account.credit_balance -= (amount - account.balance)
          account.balance = 0
          account.save
        else
          puts Rainbow("Insufficient funds and overdraft limit reached.").red
        end
        new_upgrade(account, amount, 'withdraw')
        available_balance(account_id)

        puts ""
        p account.id
      end
    
      def self.transfer_pix(amount, source_account_id, destination_account_id)
          source_account = Account.where(id: source_account_id).first
          destination_account = Account.where(id: destination_account_id).first
          if source_account && destination_account
              if (source_account.balance - source_account.credit_balance) < amount
                  puts Rainbow('Insufficient funds').red
              else
                  withdraw(source_account.id, amount)
                  new_account = Account.where(id: source_account_id).first
                  p new_account.id
                  p new_account.balance

                  deposit(destination_account.id, amount)
                  puts Rainbow('Completed transfer').green
              end
            new_upgrade(source_account, amount, 'pix_transaction')
          else
            puts Rainbow("Invalid source account or destination account, please check and try again.").red
          end
      end
    
      def self.transfer_ted(amount, source_account_id, destination_account_id)
            source_account = Account.where(id: source_account_id).first
            destination_account = Account.where(id: destination_account_id).first
          if source_account && destination_account
            ted_tax = 0.01 * amount
            if (source_account.balance - source_account.credit_balance) < (amount + ted_tax)
                puts Rainbow('Insufficient funds').red
            else
                withdraw(source_account.id, (amount + ted_tax))
                deposit(destination_account.id, amount)
                puts Rainbow('Completed transfer').green
            end
            new_upgrade(source_account, amount, 'ted_transaction')
          else
            puts Rainbow("Invalid source account or destination account, please check and try again.").red
          end
      end


      def self.available_balance(account_id)
        account = Account.where(id: account_id).first
        if account
          if account.credit_balance < 0  
          puts Rainbow("Current balance: #{account.balance + account.credit_balance}").red
          else
          puts Rainbow("Current balance: #{account.balance}").green
          end
        else
          puts Rainbow('Invalid account - doenst exist').red
        end
      end

      def self.new_upgrade(account, amount, description)
        new_upgrade = History.new(
            amount: amount,
            description: description
        )
        account.add_history(new_upgrade)      
    end

end