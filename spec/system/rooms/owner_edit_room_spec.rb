require 'rails_helper'

describe 'Owner edits a room' do 
  it 'from the details page' do
    #Arrange
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: true, 
                          disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                          cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                        closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)
    
    #Act 
    visit root_path
    login_as(owner)
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Editar'

    #Assert
    expect(page).to have_content 'Editar Quarto'
    expect(page).to have_field 'Nome', with: 'Pérola Negra'
    expect(page).to have_field 'Área', with: '15 m²'
  end 

  it 'and successfully' do
    #Arrange 
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: true, 
                          disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                          cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                        closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)
    #Act 
    visit root_path
    login_as(owner)
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Editar'
    fill_in 'Nome', with: 'Peroá'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Quarto atualizado com sucesso!'
    expect(page).to have_content 'Peroá'
  end

  it 'and keeps the mandatory fields' do
    #Arrange
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: true, 
                          disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                          cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                        closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)

    #Act 
    visit root_path
    login_as(owner)
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #Assert 
    expect(page).to have_content 'Não foi possível atualizar o quarto.'
  end

  it 'and only the owner can edit the room' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: true, 
                          disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                          cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15 m²', max_guests: 2,
                        standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                        closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)

    #Act 
    visit root_path
    login_as(owner2)
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    
    #Assert 
    expect(page).not_to have_button 'Editar'
  end
end