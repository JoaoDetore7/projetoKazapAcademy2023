module  Create_user
    def self.create_user(name, document, address, phone)
        new_user = User.create(name: name, document: document, address: address, phone: phone)
        puts Rainbow("User created, id: #{new_user.id}").green
    end
end