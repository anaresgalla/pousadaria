require 'rails_helper'

describe 'User visits homepage' do 
  it 'and see the name of the app' do 
    # Act
    visit root_path 
    
    # Assert
    expect(page).to have_content('Pousadas')
    #expect(page).to have_link('Pousadas', href: root_path)
  end 

  it 'and see the registered lodges' do 
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                  description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                  disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                  email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                  cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                  policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    Lodge.create!(name: 'Recanto do Sol', headline: 'Serra do Cipó', full_address: 'Rua das Emas, 13, Belo Horizonte - MG, Brasil. CEP: 77345-000', 
                  description: 'Pousada com vista para a serra', bedrooms: 6, max_guests: 20, pets: 'no', 
                  disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', status: 'unavailable', 
                  email: 'recantodosol@gmail.com', phone_number: '38985694512', corporate_name: 'Fernandes e Oliveira LTDA',
                  cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                  policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)

    #Act
    visit(root_path)

    #Assert
    expect(page).not_to have_content('Não existem pousadas cadastradas')
    expect(page).to have_content('Pousada do Mar')
    expect(page).to have_content('Praia dos Coqueiros')
    expect(page).to have_content('Marataízes')
    expect(page).to have_content('ES')
    expect(page).to have_content('Brasil')

    expect(page).to have_content('Recanto do Sol')
    expect(page).to have_content('Serra do Cipó')
    expect(page).to have_content('Belo Horizonte')
    expect(page).to have_content('MG')
    expect(page).to have_content('Brasil')
    expect(page).to have_content('Pousada com vista para a serra')
  end 

  it 'and there are no registered lodges' do
    #Act
    visit(root_path)
    #Assert
    expect(page).to have_content('Não existem pousadas cadastradas')
  end 
end
