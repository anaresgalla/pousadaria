require 'rails_helper'

describe 'User sees the rooms of a lodge' do
  it 'successfully' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                        closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    
    #Assert
    expect(page).to have_content 'Pérola Negra'
    
  end 

  it 'sees details of the room except for the special pricings' do 
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                        closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)
    special_pricing = SpecialPricing.create!(start_date: 2.day.ago, end_date: 2.day.from_now, price: 100, room: room)

    #Act
    visit root_path 
    click_on 'Pousada do Mar' 
    click_on 'Pérola Negra'
    
    #Assert
    expect(page).to have_content 'Quarto de frente para o mar'
    expect(page).to have_content 'Banheiro: true'
    expect(page).to have_content 'Área: 15 m²' 
    expect(page).to have_content 'Diária Padrão: R$ 100,00'
    expect(page).not_to have_content 'Preço Especial'
  end 

  it 'and sees only vancant rooms' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                         state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                         max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                         status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                         corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                         policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room1 = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                         standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                         closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)
    room2 = Room.create!(name: 'Iemanjá', description: 'Quarto com praia reservada', area: '20 m²', max_guests: 4,
                         standard_overnight: '350,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                         closet: true, disabled_facilities: true, safe: true, vacant: false, lodge: lodge)

    #Act
    visit root_path 
    click_on 'Pousada do Mar' 
    
    #Assert
    expect(page).to have_content 'Pérola Negra'
    expect(page).not_to have_content 'Iemanjá'
  end 
end
