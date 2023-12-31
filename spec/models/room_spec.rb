require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'false when photo is not of the supported format' do
        #Arrange: 
        owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                              password: '123456')
        l = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
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
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                            closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                            vacant: 'Disponível', lodge: l)
        room.pictures.attach(io: File.open('spec/images/img.gif'),
                             filename: 'img.gif', content_type: 'image/gif')
        room.save

        #Act:
        room.valid?
        
        #Assert: 
        expect(room.errors[:pictures]).to include 'Formatos permitidos: jpg, jpeg e png.'
      end   
    end
  end
end
