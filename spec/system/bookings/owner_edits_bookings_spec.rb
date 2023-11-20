require 'rails_helper'

describe 'Owner sees bookings of their lodge' do
  it 'and checks guests in' do
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
    booking1 = Booking.create!(check_in: 1.day.ago, check_out: 5.days.from_now, 
                               guests: 2, room: room, user: user)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

     #Act
     login_as owner 
     visit root_path 
     click_on 'Reservas'
     click_on booking1.code
     click_on 'Confirmar check in'
     
     #Assert
     expect(page).to have_content 'Check-in realizado.'
  end

  it 'and sees only active stays' do
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
    booking1 = Booking.create!(check_in: Date.today, check_out: 5.days.from_now, 
                               guests: 2, room: room, user: user, status: 5)
    booking1 = Booking.create!(check_in: 7.days.from_now, check_out: 15.days.from_now, 
                               guests: 1, room: room, user: user, status: 15)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    login_as owner 
    visit root_path 
    click_on 'Reservas'
    click_on 'Estadias Ativas'
    
    #Assert
    expect(page).to have_content 'Ativa'
    expect(page).to have_content 'Pérola Negra'
    expect(page).to have_selector('.booking', count: 1)
  end

  it 'and sees only their own lodge active stays' do
    #Arrange
    owner1 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    owner2 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                           password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                        neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                        country: 'Brasil', zip_code: '12345-985', 
                        description: 'Pousada em frente à praia', bedrooms: 5, 
                        max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                        check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                        email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                        corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                        payment_method: "Cartão de crédito, Pix", 
                        policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', 
                           neighborhood: 'Serrinha', city: 'Belo Horizonte', state: 'MG', 
                           country: 'Brasil', zip_code: '77345-000', 
                           description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: false, disabled_facilities: 'Rampas de acesso', 
                           check_in: '17:00', check_out: '14:00', status: 'Ativa', 
                           email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', 
                           payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    room1 = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge1)
    room2 = Room.create!(name: 'Iemanjá', description: 'Quarto com praia reservada', 
                         area: '20', max_guests: 4, standard_overnight: '350,00 BRL', 
                         bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                         closet: 'Sim', disabled_facilities: 'Sim', safe: 'Sim', 
                         vacant: 'Disponível', lodge: lodge2)
    user = User.create!(name: 'Ana', email: 'ana@email.com', 
                        password: '123456', cpf: '27111653025')
    booking1 = Booking.create!(check_in: Date.today, check_out: 5.days.from_now, 
                               guests: 2, room: room1, user: user, status: 5)
    booking2 = Booking.create!(check_in: 7.days.from_now, check_out: 15.days.from_now, 
                               guests: 1, room: room2, user: user, status: 15)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    login_as owner1 
    visit root_path 
    click_on 'Reservas'
    click_on 'Estadias Ativas'
    
    #Assert
    expect(page).to have_content 'Ativa'
    expect(page).to have_content 'Pérola Negra'
    expect(page).not_to have_content 'Iemanjá'
  end
end