require 'rails_helper'

describe 'User sees the rooms of a lodge' do
  it 'successfully' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                     description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                     disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                     email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                     cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                     policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: 'yes', balcony: 'yes', ac: 'yes', tv: 'yes', 
                        closet: 'yes', disabled_facilities: 'yes', safe: 'no', vacant: 'yes', lodge: lodge)

    #Act
    visit(root_path)
    click_on('Pousada do Mar')
    
    #Assert
    expect(page).to have_content 'Pérola Negra'
    
  end 

  it 'sees details of the room' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                     description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                     disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                     email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                     cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                     policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: 'true', balcony: 'true', ac: 'true', tv: 'true', 
                        closet: 'true', disabled_facilities: 'true', safe: 'false', vacant: 'true', lodge: lodge)

    #Act
    visit(root_path)
    click_on('Pousada do Mar')
    click_on('Pérola Negra')
    
    #Assert
    expect(page).to have_content 'Quarto de frente para o mar'
    expect(page).to have_content 'Banheiro: true'
    expect(page).to have_content 'Área: 15 m²' 
    expect(page).to have_content 'Diária Padrão: 150,00 BRL'
  end 

#   it 'and sees only vancant rooms' do
#     #Arrange
#     owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
#     l = Lodge.create(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
#                      description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
#                      disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
#                      email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
#                      cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
#                      policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

#     #Act
#     visit(root_path)
#     click_on('Pousada do Mar')

#     #Assert
#     expect(page).to have_content('Praia dos Coqueiros')
#     expect(page).to have_content('Endereço: Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985')
#     expect(page).to have_content('Almeida e Filhos LTDA')
#     expect(page).to have_content('E-mail: pousadadomar@gmail.com')
#     expect(page).to have_content('Número de quartos: 5')
#   end 
end
