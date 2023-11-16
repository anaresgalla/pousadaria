require 'rails_helper'

RSpec.describe SpecialPricing, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'any mandatory field is empty' do
        #Arrange
        owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
        lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                              country: 'Brasil', zip_code: '12345-985', 
                              description: 'Pousada em frente à praia', bedrooms: 5, 
                              max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                              check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                              email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                              corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                              payment_method: "Cartão de crédito, Pix", 
                              policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                            area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                            closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                            vacant: 'Sim', lodge: lodge)
        special_pricing = SpecialPricing.new(start_date: nil, end_date: nil, 
                                             price: '', room: room)

        #Act
        result = special_pricing.valid?

        #Assert
        expect(result).to eq false 
      end
    end

    context 'valid dates' do
      it 'successfully' do
        #Arrange
        owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
        lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                              country: 'Brasil', zip_code: '12345-985', 
                              description: 'Pousada em frente à praia', bedrooms: 5, 
                              max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                              check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                              email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                              corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                              payment_method: "Cartão de crédito, Pix", 
                              policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                            area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                            closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                            vacant: 'Sim', lodge: lodge)
        special_pricing1 = SpecialPricing.create!(start_date: 2.day.ago, end_date: 2.day.from_now, 
                                                  price: 100, room: Room.last)
        special_pricing2 = SpecialPricing.new(start_date: 1.month.ago, end_date: 1.week.ago, 
                                              price: 200, room: Room.last)
        
        #Act
        result = special_pricing2.valid?

        #Assert
        expect(result).to eq true 
        
      end

      it 'and special pricing for the room overlaps' do
        #Arrange
        owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
        lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                              country: 'Brasil', zip_code: '12345-985', 
                              description: 'Pousada em frente à praia', bedrooms: 5, 
                              max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                              check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                              email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                              corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                              payment_method: "Cartão de crédito, Pix", 
                              policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                            area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                            closet: true, disabled_facilities: 'Sim', safe: 'Não', 
                            vacant: 'Sim', lodge: lodge)
        special_pricing1 = SpecialPricing.create!(start_date: 2.day.ago, end_date: 2.day.from_now, 
                                                  price: 100, room: Room.last)
        special_pricing2 = SpecialPricing.new(start_date: 1.day.ago, end_date: 1.day.from_now, 
                                              price: 200, room: Room.last)
        #Assert
        expect(special_pricing2).to_not be_valid
        expect(special_pricing2.errors[:base]).to include 'O quarto já possui um preço especial nessa data.'
      end


      it 'and start date is after end date' do
        #Arrange
        owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
        lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                              country: 'Brasil', zip_code: '12345-985', 
                              description: 'Pousada em frente à praia', bedrooms: 5, 
                              max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                              check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                              email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                              corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                              payment_method: "Cartão de crédito, Pix", 
                              policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                            area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL',
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                            closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                            vacant: 'Sim', lodge: lodge)
        special_pricing = SpecialPricing.create(start_date: Date.today, end_date: 1.day.ago, 
                                                price: 100, room: room)

        #Act
        result = special_pricing.valid?

        #Assert
        expect(result).to eq false 
        expect(special_pricing.errors.full_messages).to include 'A data informada está incorreta.'
     end
    
      it "and start and end dates are equal" do
        #Arrange
        owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
        lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                              country: 'Brasil', zip_code: '12345-985', 
                              description: 'Pousada em frente à praia', bedrooms: 5, 
                              max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                              check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                              email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                              corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                              payment_method: "Cartão de crédito, Pix", 
                              policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                            area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                            bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                            closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                            vacant: 'Sim', lodge: lodge)
        special_pricing = SpecialPricing.create(start_date: Date.today, end_date: Date.today, 
                                                price: 100, room: room)

        #Act
        result = special_pricing.valid?

        #Assert
        expect(result).to eq false 
        expect(special_pricing.errors.full_messages).to include 'A data informada está incorreta.'
      end
    end 
  end
end 