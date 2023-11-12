require 'rails_helper'

describe 'Owner registers a new lodge' do 
  it 'from the homepage' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    
    #Act
    visit root_path
    click_on 'Cadastrar Pousada'
    login_as(owner)

    #Assert
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Modo de Pagamento'
  end

  it 'successfully' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
        
    #Act
    visit root_path
    login_as(owner)
    fill_in 'Nome', with: 'Pousada do Mar'
    fill_in 'Descrição', with: 'Pousada em frente à praia'
    fill_in 'Endereço', with: 'Avenida Beira Mar, 1500' 
    fill_in 'Bairro', with: 'Coqueiros' 
    fill_in 'Cidade', with: 'Marataízes' 
    fill_in 'Estado', with: 'ES' 
    fill_in 'País', with: 'Brasil' 
    fill_in 'CEP', with: '12345-985'
    fill_in 'CNPJ', with: '08945909000124'
    find('#lodge_pets', visible: true).check
    fill_in 'Número de quartos', with: 5
    fill_in 'Máximo de hóspedes', with: 12
    fill_in 'Acessibilidade para PCD', with: 'Menu em Braile'
    fill_in 'Check In', with: '15:00'
    fill_in 'Check Out', with: '12:00'    
    fill_in 'E-mail', with: 'pousadadomar@gmail.com'
    fill_in 'Telefone', with: '28985647114'
    fill_in 'Razão Social', with: 'Almeida e Filhos LTDA'
    fill_in 'Modo de Pagamento', with: 'Cartão de crédito, Pix'
    fill_in 'Políticas de Uso', with: 'Proibido fumar no local. Silêncio a partir das 22h.'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Pousada do Mar'    
    expect(page).to have_content 'Marataízes'    
    expect(page).to have_content 'Pousada cadastrada com sucesso!'
  end 

  it 'and with incomplete information' do 
    #Arrange 
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    #Act
    visit root_path
    click_on 'Cadastrar Pousada'
    login_as(owner)
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Políticas de Uso', with: ''
    fill_in 'Check In', with: ''
    click_on 'Enviar'
    
    #Assert
    expect(page).to have_content 'Pousada não cadastrada.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Políticas de Uso não pode ficar em branco'
    expect(page).to have_content 'Check In não pode ficar em branco'
  end 

  it 'and tries to register more than one lodge' do 
    #Arrange 
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    login_as(owner)
    l = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                     state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                     max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                     status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                     corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                     policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act
    visit root_path
    click_on 'Cadastrar Pousada'
    fill_in 'Nome', with: 'Pousada do Luar'
    fill_in 'Descrição', with: 'Pousada em frente à praia'
    fill_in 'CNPJ', with: '08945909000124'
    fill_in 'Endereço', with: 'Avenida Beira Mar, 2569'
    fill_in 'Cidade', with: 'Marataízes' 
    fill_in 'Estado', with: 'ES' 
    fill_in 'País', with: 'Brasil' 
    fill_in 'CEP', with: '12345-985'
    find('#lodge_pets', visible: true).check
    fill_in 'Número de quartos', with: 5
    fill_in 'Máximo de hóspedes', with: 12
    fill_in 'Acessibilidade para PCD', with: 'Menu em Braile'
    fill_in 'Check In', with: '15:00'
    fill_in 'Check Out', with: '12:00'
    select 'available', from: 'Status'
    fill_in 'E-mail', with: 'pousadadoluar@gmail.com'
    fill_in 'Telefone', with: '28985647114'
    fill_in 'Razão Social', with: 'Almeida e Filhos LTDA'
    fill_in 'Modo de Pagamento', with: 'Cartão de crédito, Pix'
    fill_in 'Políticas de Uso', with: 'Proibido fumar no local. Silêncio a partir das 22h.'
    click_on 'Enviar'
        
    #Assert
    expect(page).to have_content 'Owner já está em uso'
    expect(current_path).not_to have_content 'Pousada do Luar'
  end 
end
