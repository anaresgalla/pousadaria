require 'rails_helper'

describe 'User is booking a room' do
  it 'and is not signed up' do
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
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    fill_in 'Data de Entrada', with: 1.day.from_now
    fill_in 'Data de Saída', with: 5.days.from_now
    fill_in 'Número de Hóspedes', with: 2
    click_on 'Consultar Disponibilidade'
    click_on 'Reservar o Quarto'
    
    #Assert
    expect(current_path).to eq new_user_registration_path
  end

  it 'and is redirected to the booking page after sign up' do
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
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    fill_in 'Data de Entrada', with: 1.day.from_now
    fill_in 'Data de Saída', with: 5.days.from_now
    fill_in 'Número de Hóspedes', with: 2
    click_on 'Consultar Disponibilidade'
    click_on 'Reservar o Quarto'
    click_on 'Sign up'
    fill_in 'Nome', with: 'Ana'
    fill_in 'Cpf', with: '27111653025'
    fill_in 'E-mail', with: 'ana@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Sign up'

    #Assert
    expect(page).to have_content 'Dados para Reserva:'
    expect(page).to have_link 'Reservar o Quarto'
  end

  it 'and is logged in' do
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
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: '123456', cpf: '27111653025')

    #Act
    visit root_path
    login_as user, scope: :user
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    fill_in 'Data de Entrada', with: 1.day.from_now
    fill_in 'Data de Saída', with: 5.days.from_now
    fill_in 'Número de Hóspedes', with: 2
    click_on 'Consultar Disponibilidade'
    click_on 'Reservar o Quarto'
    click_on 'Confirmar Reserva'

    #Assert
    expect(current_path).to eq my_bookings_path
  end
  
  it 'and is successful and sees his bookings on my bookings page' do
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
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    user = User.create!(name: 'Ana', email: 'ana@email.com', password: '123456', cpf: '27111653025')
    booking = Booking.create!(check_in: 1.day.from_now, check_out: 5.days.from_now, 
                               guests: 2, room: room, user: user)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    login_as user, scope: :user
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    fill_in 'Data de Entrada', with: 7.day.from_now
    fill_in 'Data de Saída', with: 10.days.from_now
    fill_in 'Número de Hóspedes', with: 2
    click_on 'Consultar Disponibilidade'
    click_on 'Reservar o Quarto'
    click_on 'Confirmar Reserva'
    click_on '12345678'

    #Assert
    expect(page).to have_content 'Código da Reserva'
  end
end 
