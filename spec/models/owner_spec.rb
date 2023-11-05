require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      #Arrange
      o = Owner.new(name: 'Julia Almeida', email: 'julia@gmail.com')
      #Act
      result = o.description
      #Assert
      expect(result).to eq ('Julia Almeida - julia@gmail.com')
    end 
  end
end
