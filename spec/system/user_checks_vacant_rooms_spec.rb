require 'rails_helper'

describe 'User checks vacant rooms of a lodge' do
  it 'and finds the buttom to book a room' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', vacant: 'Disponível', lodge: lodge)

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    
    #Assert
    expect(page).to have_link 'Reservar'
  end

  it 'and fills in the info about the booking' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', vacant: 'Disponível', lodge: lodge)

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    
    #Assert
    expect(page).to have_content 'Data de Entrada'
  end

  it 'and does not leave mandatory fields blank' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', vacant: 'Disponível', lodge: lodge)
    
    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    fill_in 'Data de Entrada', with: ''
    fill_in 'Data de Saída', with: ''
    fill_in 'Número de Hóspedes', with: ''
    click_on 'Consultar Disponibilidade'

    #Assert
    expect(page).to have_content 'Data de Entrada não pode ficar em branco'
    expect(page).to have_content 'Data de Saída não pode ficar em branco'
    expect(page).to have_content 'Número de Hóspedes não pode ficar em branco'
  end

  # it 'and the room is vacant' do
  #   #Arrange
  #   owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
  #   lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
  #                        state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
  #                        max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
  #                        status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
  #                        corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
  #                        policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
  #   room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
  #                       standard_overnight: '150,00 BRL', bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
  #                       closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', vacant: 'Disponível', lodge: lodge)

  #   #Act
  #   visit root_path
  #   click_on 'Pousada do Mar'
  #   click_on 'Pérola Negra'
  #   click_on 'Reservar'
  #   fill_in 'Check In', with: 1.day.from_now
  #   fill_in 'Check Out', with: 10.days.from_now
  #   fill_in 'Número de Hóspedes', with: 2
  #   fill_in 'Valor Total', with: 1350
  #   click_on 'Consultar Disponibilidade'

  #   #Assert
  #   expect(page).to have_content 'O quarto está disponível.'
  #   expect(page).to have_content 'Valor Total:'
  # end

  it 'and the room is not vacant' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', vacant: 'Disponível', lodge: lodge)
    booking = Booking.create!(check_in: 1.day.from_now, check_out: 5.days.from_now, guests: 2, total_price: 100, room: room)

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    fill_in 'Data de Entrada', with: 2.days.from_now
    fill_in 'Data de Saída', with: 6.days.from_now
    fill_in 'Número de Hóspedes', with: 1
    fill_in 'Valor Total', with: 150
    click_on 'Consultar Disponibilidade'

    #Assert
    expect(page).to have_content 'O quarto não está disponível na data de entrada.'
  end

  it 'and the number of guests exceeds the maximum' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', vacant: 'Disponível', lodge: lodge)
    

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Reservar'
    fill_in 'Data de Entrada', with: 1.day.from_now
    fill_in 'Data de Saída', with: 10.days.from_now
    fill_in 'Número de Hóspedes', with: 3
    fill_in 'Valor Total', with: 1500
    click_on 'Consultar Disponibilidade'

    #Assert
    expect(page).to have_content 'O número de hóspedes excede a capacidade máxima do quarto.'
    
  end
end