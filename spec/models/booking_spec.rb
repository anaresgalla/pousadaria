require 'rails_helper'

RSpec.describe Booking, type: :model do
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
                            area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL',   
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', closet: 'Sim', 
                            disabled_facilities: 'Sim', safe: 'Não', vacant: 'Sim', lodge: lodge)
        booking = Booking.new(check_in: nil, check_out: nil, guests: nil, room: room)

        #Act
        result = booking.valid?

        #Assert
        expect(result).to eq false 
      end

      it 'every booking has an unique 8-digit code' do
        #Arrange
        booking1 = Booking.create
        booking2 = Booking.create

        #Assert
        expect(booking1.code.length).to eq 8
        expect(booking2.code.length).to eq 8
        expect(booking1.code).not_to eq booking2.code
      end
    end 
  end
end
