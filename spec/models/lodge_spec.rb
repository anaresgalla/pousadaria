require 'rails_helper'

RSpec.describe Lodge, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'false when name is empty' do
        #Arrange
        owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
        l = Lodge.create(name: '', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                         description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                         disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                         email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                         cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        #Act
        result = l.valid?
        #Assert
        expect(result).to eq false 
      end 

      it 'false when check-in is empty' do
        #Arrange
        owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
        l = Lodge.create(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                         description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                         disabled_facilities: 'Menu em Braile', check_in: '', check_out: '12:00', status: 'available', 
                         email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                         cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        #Act
        result = l.valid?
        #Assert
        expect(result).to eq false 
      end 

      it 'false when cnpj is empty' do
        #Arrange
        owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
        l = Lodge.create(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                         description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                         disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                         email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                         cnpj: '', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        
        expect(l.valid?).to eq false 
      end

      it 'false when owner is empty' do
        #Arrange
        l = Lodge.create(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                         description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                         disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                         email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                         cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: nil)
        
        expect(l.valid?).to eq false 
      end 

      it 'false when owner is already in use' do
        #Arrange: 
        owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
        l = Lodge.create(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                         description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                         disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                         email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                         cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        l2 = Lodge.new(name: 'Recanto do Sol', headline: 'Serra do Cipó', full_address: 'Rua das Emas, 13, Belo Horizonte - MG, Brasil. CEP: 77345-000', 
                           description: 'Pousada com vista para a serra', bedrooms: 6, max_guests: 20, pets: 'no', 
                           disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', status: 'unavailable', 
                           email: 'recantodosol@gmail.com', phone_number: '38985694512', corporate_name: 'Fernandes e Oliveira LTDA',
                           cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner)

        #Act:
        result = l2.valid?
        
        #Assert: 
        expect(result).to eq false 
      end   
    end 
  end
end
