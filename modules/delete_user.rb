module Delete_user
    def self.delete_user_by_id(user_id)
        user = User.where(id: user_id).first
        if user.nil?
        puts Rainbow("User with ID #{user_id} not found.").red
        return
        end
        accounts_to_delete = Account.where(user_id: user.id)
        accounts_to_delete.each(&:delete)
        user.delete
        puts Rainbow("User has been deleted.").green
    end
end