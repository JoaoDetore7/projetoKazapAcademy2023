require 'sequel'
require 'uuid'
require 'rainbow'
require 'json'


DB = Sequel.sqlite('db/bank_system.db')

require_relative 'models/users'
require_relative 'models/accounts'
require_relative 'models/historys'
require_relative 'modules/create_account'
require_relative 'modules/create_user'
require_relative 'modules/delete_user'
require_relative 'modules/application'
require_relative 'modules/history_account'

loop do
puts "--------- BANK SYSTEM  - RUBY ---------"
puts ""
puts "Digite uma opção para iniciar:"
puts "1-Create user"
puts "2-Create account"
puts "3-Use bank"
puts "4-Logout"
puts ""
print "Type your option: "
option = gets.chomp.to_i

case option


    when 1
        puts "----------------------------"
        puts "Create user"
        print 'Enter the name you want to create: '
        name = gets.chomp
        print 'Type the document: '
        document = gets.chomp
        print 'Type the address: '
        address = gets.chomp
        print 'Type the phone: '
        phone = gets.chomp
        user = Create_user.create_user(name, document, address, phone)
        puts "----------------------------"

    when 2
        puts "----------------------------"
        puts "Open account"
        print "Type ID of the user to create: "
        user_id = gets.chomp.to_i
        Create_account.create_new_account(user_id)
        puts "----------------------------"

    when 3
        loop do
        puts "----------------------------"
        puts "1-Deposit"
        puts "2-Withdraw"
        puts "3-Transfer funds"
        puts "4-Current balance"
        puts "5-Transaction history"
        puts "6-Delete account"
        puts "0-Back"
        puts ""
        print "Type your option: "
        option2 = gets.chomp.to_i
            case option2
            when 0
                break
            when 1
                puts "Deposit."
                print 'Type ID from account to deposit: '
                account_id = gets.chomp.to_i
                print 'Amount: '
                amount = gets.chomp.to_f
                Aplication.deposit(account_id, amount)
                break
            when 2
                puts "Withdraw."
                print 'Type ID from account to withdraw: '
                account_id = gets.chomp.to_i
                print 'Amount: '
                amount = gets.chomp.to_f
                Aplication.withdraw(account_id, amount)
                break
            when 3
                puts "Transfer funds."
                print 'Type ID from account to transfer: '
                source_account_id = gets.chomp.to_i
                print 'Type ID from account to receive: '
                destination_account_id = gets.chomp.to_i
                print 'Amount: '
                amount = gets.chomp.to_f
                print 'TED or PIX: '
                transaction_type = gets.chomp
                if transaction_type == 'PIX'
                Aplication.transfer_pix(amount, source_account_id, destination_account_id)
                elsif transaction_type == 'TED'
                Aplication.transfer_ted(amount, source_account_id, destination_account_id)
                else
                    puts Rainbow("Invalid option, type PIX or TED").red 
                break
                end
            when 4
                puts "Current balance."
                print ('Type ID you want to check balance: ')
                account_id = gets.chomp.to_i
                Aplication.available_balance(account_id)
                break
            when 5
                puts "Transaction history."
                print ('Type ID of the account that you want to check transaction history: ')
                account_id = gets.chomp.to_i
                # History_account.show_last_statements(account_id)
                History_account.export_history(account_id)
                break
            when 6
                puts "Delete account"
                print ('Type ID you want to delete: ')
                user_id = gets.chomp.to_i
                Delete_user.delete_user_by_id(user_id)
                break
            else
                puts Rainbow("Invalid option, try again").yellow
            end
        end    
        puts "----------------------------"

    when 4
        puts "----------------------------"
        puts Rainbow("Logout.").red
        puts "----------------------------"
        break
    else 
        puts Rainbow("Invalid option, try again").yellow
    end
end