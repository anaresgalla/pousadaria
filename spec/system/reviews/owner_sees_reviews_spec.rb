require 'rails_helper'

describe 'Owner sees reviews' do
  include ActiveSupport::Testing::TimeHelpers
  
  it 'and successfully' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
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
                        vacant: 'Disponível', lodge: lodge)
    user = User.create!(name: 'Ana', email: 'ana@email.com', 
                        password: '123456', cpf: '27111653025')
    booking = Booking.create!(check_in: 1.day.ago, check_out: 5.days.from_now, 
                              guests: 2, room: room, user: user, status: 5)
    review = Review.create!(rating: 5, comment: 'Excelente pousada!', booking: booking)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    booking.completed! 
    travel_to 10.days.from_now do
      login_as owner
      visit root_path
      click_on 'Avaliações'
     
      #Assert
      expect(page).to have_link booking.code
      expect(page).to have_content 'Nota: 5'
      expect(page).to have_content 'Excelente pousada!'
    end
  end

  it 'and replies the review' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
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
                        vacant: 'Disponível', lodge: lodge)
    user = User.create!(name: 'Ana', email: 'ana@email.com', 
                        password: '123456', cpf: '27111653025')
    booking = Booking.create!(check_in: 1.day.ago, check_out: 5.days.from_now, 
                              guests: 2, room: room, user: user, status: 5)
    review = Review.create!(rating: 5, comment: 'Excelente pousada!', booking: booking)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    booking.completed! 
    travel_to 10.days.from_now do
      login_as owner
      visit root_path
      click_on 'Avaliações'
      click_on booking.code
      fill_in 'Responder comentário:', with: 'Muito obrigada!'
      click_on 'Enviar'
     
      #Assert
      expect(page).to have_content 'Resposta enviada!'
      expect(page).to have_content 'Muito obrigada!'
    end
  end
end
