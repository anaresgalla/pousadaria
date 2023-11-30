require 'rails_helper'

include ActiveSupport::Testing::TimeHelpers

RSpec.describe Review, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'any mandatory field is empty' do
        #Arrange
        owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
        lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                              country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', 
                              bedrooms: 5, max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                              check_in: '15:00', check_out: '12:00', status: 'Ativa',   
                              email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                              corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                              payment_method: "Cartão de crédito, Pix", 
                              policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                            area: '15 m²', max_guests: 2, standard_overnight: '150,00',   
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', closet: 'Sim', 
                            disabled_facilities: 'Sim', safe: 'Não', vacant: 'Sim', lodge: lodge)
        user = User.create!(name: 'Ana', email: 'ana@email.com', password: '123456', cpf: '27111653025')
        booking = Booking.create!(check_in: 2.days.ago, check_out: 15.days.from_now, 
                                    guests: 2, room: room, user: user, status: 15)
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        review = Review.create(rating: nil, comment: nil)

        #Act
        result = review.valid?

        #Assert
        expect(result).to eq false 
      end
    end
  end
end