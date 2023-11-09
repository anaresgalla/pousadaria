require 'rails_helper'

describe 'User sees details of a lodge' do
  it 'and sees additional info' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    l = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                     state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                     max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                     status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                     corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                     policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act
    visit root_path
    click_on 'Pousada do Mar'

    #Assert
    expect(page).to have_content 'Coqueiros'
    expect(page).to have_content 'Endereço: Avenida Beira Mar, 1500'
    expect(page).to have_content 'E-mail: pousadadomar@gmail.com'
    expect(page).to have_content 'Número de quartos: 5'
  end 
  
  it 'and does not see CNPJ and corporate name' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    l = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                     state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                     max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                     status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                     corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                     policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act
    visit root_path
    click_on 'Pousada do Mar'

    #Assert
    expect(page).to have_content 'Coqueiros'
    expect(page).to have_content 'Endereço: Avenida Beira Mar, 1500'
    expect(page).not_to have_content 'Almeida e Filhos LTDA'
    expect(page).not_to have_content 'CNPJ'
  end 

  it 'and goes back to the homepage' do
    #Arrange 
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    l = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                     state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                     max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                     status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                     corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                     policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act 
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Página Inicial'

    #Assert 
    expect(current_path).to eq root_path
  end 
end 
