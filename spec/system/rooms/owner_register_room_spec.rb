require 'rails_helper'

describe 'Owner registers a new room' do 
  it 'from the lodge page' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    
    #Act
    visit root_path
    login_as owner
    click_on 'Pousada do Mar'
    click_on 'Cadastrar Quarto'
    
    #Assert
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
  end

  it 'successfully' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
        
    #Act
    visit root_path
    login_as owner
    click_on 'Pousada do Mar'
    click_on 'Cadastrar Quarto'
    fill_in 'Nome', with: 'Peroá'
    fill_in 'Descrição', with: 'Quarto saída para o quintal'
    fill_in 'Área', with: '10 m²'
    fill_in 'Máximo de Hóspedes', with: '4'
    fill_in 'Diária Padrão', with: '100 BRL'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Peroá' 
    expect(page).to have_content 'Quarto saída para o quintal'        
    expect(page).to have_content 'Quarto cadastrado com sucesso!'
  end 

  it 'and with incomplete information' do 
    #Arrange 
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act
    visit root_path
    login_as owner 
    click_on 'Pousada do Mar'
    click_on 'Cadastrar Quarto'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'
    
    #Assert
    expect(page).to have_content 'Quarto não cadastrado.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
  end 
end
