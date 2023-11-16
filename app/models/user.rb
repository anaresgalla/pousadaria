class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates :cpf, cpf: { message: 'CPF válido' }

  def description
    "#{name} - #{email}"
  end 
end
