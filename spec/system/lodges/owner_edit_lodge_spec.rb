require 'rails_helper'

describe 'Owner edits a lodge' do 
  it 'from the details page' do
    #Arrange
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    
    #Act 
    visit root_path
    login_as(owner)
    click_on 'Pousada do Mar'
    click_on 'Editar'

    #Assert
    expect(page).to have_content 'Editar Pousada'
    expect(page).to have_field 'Nome', with: 'Pousada do Mar'
    expect(page).to have_field 'CNPJ', with: '08945909000124'
    expect(page).to have_field 'E-mail', with: 'pousadadomar@gmail.com'
  end 

  it 'and successfully' do
    #Arrange 
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    
    #Act 
    visit root_path
    login_as(owner)
    click_on 'Pousada do Mar'
    click_on 'Editar'
    fill_in 'Nome', with: 'Pousada das Sereias'
    click_on 'Enviar'

    #Assert 
    expect(page).to have_content 'Pousada atualizada com sucesso!'
    expect(page).to have_content 'Nome: Pousada das Sereias'
  end

  it 'and keeps the mandatory fields' do
    #Arrange
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act 
    visit root_path
    login_as(owner)
    click_on 'Pousada do Mar'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #Assert 
    expect(page).to have_content 'Não foi possível atualizar a pousada.'
  end

  it 'and only the owner can edit their lodge' do
    #Arrange
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act 
    visit root_path
    login_as(owner2)
    click_on 'Pousada do Mar'
    
    #Assert 
    expect(page).not_to have_button 'Editar'
  end
end
