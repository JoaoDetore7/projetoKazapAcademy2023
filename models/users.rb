class User < Sequel::Model
  plugin :validation_helpers
  one_to_many :accounts
      
  def validate
    validates_presence [:name, :document, :address, :phone]
    validates_unique [:document]
  end
 end