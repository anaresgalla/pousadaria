require 'rails_helper'

describe 'User visits homepage' do 
  it 'and see the name of the app' do 
    # Act
    visit root_path 
    
    # Assert
    expect(page).to have_content 'Pousadas'
  end 

  it 'and see only available registered lodges' do  
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                  state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                  max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                  status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                  corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                  policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                  state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                  max_guests: 20, pets: false, disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                  status: 'unavailable', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                  corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                  policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)

    #Act
    visit root_path 

    #Assert
    expect(page).not_to have_content 'Não existem pousadas cadastradas'
    expect(page).to have_content 'Pousada do Mar'
    expect(page).to have_content 'Marataízes'

    expect(page).not_to have_content 'Recanto do Sol'  
  end 

  it 'and sees the three most recent logdes separated from the others' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    owner3 = Owner.create!(name: 'Márcia Gomes', email: 'mrsgomes@gmail.com', password: '123456')
    owner4 = Owner.create!(name: 'Laís Nunes', email: 'lanunes@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: false, disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'available', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    lodge3 = Lodge.create!(name: 'Jardim de espelhos', address: 'Alameda Tuiuiú, 58', neighborhood: 'Horizonte', city: 'Bonito', state: 'MS',
                           country: 'Brasil', zip_code: '58961-222', description: 'Pousada em contato com a natureza', bedrooms: 15, 
                           max_guests: 45, pets: false, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'available', email: 'jardimdosespelhos@gmail.com', phone_number: '59987458523', 
                           corporate_name: 'Pantanal Resorts LTDA', cnpj: '57568391000162', payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.', owner: owner3)
    lodge4 = Lodge.create!(name: 'Morada do Curupira', address: 'Avenida Solimões, 789',  neighborhood: 'Seringueiras', city: 'Manaus', state: 'AM', 
                           country: 'Brasil', zip_code: '19845-666', description: 'Pousada rodeada pela maior floresta do mundo', bedrooms: 12, 
                           max_guests: 44, pets: true, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'available', email: 'moradadocurupira@gmail.com', phone_number: '75984596231', 
                           corporate_name: 'Amazonia pousadas SA', cnpj: '76773869000130', payment_method: "Cartão de crédito, Cartão de débito, Pix e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido fumar no local. Não aceitamos cheques.', owner: owner4)

    #Act
    visit root_path

    #Assert
    within('#lodges') do
      expect(page).to have_selector('h3', text: 'Pousadas mais Recentes:')
      recent_lodges = all('h4 a').map(&:text)
      expect(recent_lodges).to have_content 'Recanto do Sol'
      expect(recent_lodges).to have_content 'Jardim de espelhos'
      expect(recent_lodges).to have_content 'Morada do Curupira'
      expect(page).to have_selector('h3', text: 'Outras Pousadas:')
      other_lodges = all('h4 a').map(&:text)
      expect(other_lodges).to have_content 'Pousada do Mar'
    end
  end 

  it 'and sees the cities menu in alphabetical order' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    owner3 = Owner.create!(name: 'Márcia Gomes', email: 'mrsgomes@gmail.com', password: '123456')
    owner4 = Owner.create!(name: 'Laís Nunes', email: 'lanunes@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: false, disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'available', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    lodge3 = Lodge.create!(name: 'Jardim de espelhos', address: 'Alameda Tuiuiú, 58', neighborhood: 'Horizonte', city: 'Bonito', state: 'MS',
                           country: 'Brasil', zip_code: '58961-222', description: 'Pousada em contato com a natureza', bedrooms: 15, 
                           max_guests: 45, pets: false, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'available', email: 'jardimdosespelhos@gmail.com', phone_number: '59987458523', 
                           corporate_name: 'Pantanal Resorts LTDA', cnpj: '57568391000162', payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.', owner: owner3)
    lodge4 = Lodge.create!(name: 'Morada do Curupira', address: 'Avenida Solimões, 789',  neighborhood: 'Seringueiras', city: 'Manaus', state: 'AM', 
                           country: 'Brasil', zip_code: '19845-666', description: 'Pousada rodeada pela maior floresta do mundo', bedrooms: 12, 
                           max_guests: 44, pets: true, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'available', email: 'moradadocurupira@gmail.com', phone_number: '75984596231', 
                           corporate_name: 'Amazonia pousadas SA', cnpj: '76773869000130', payment_method: "Cartão de crédito, Cartão de débito, Pix e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido fumar no local. Não aceitamos cheques.', owner: owner4)

    #Act
    visit root_path

    #Assert
    within('#lodges') do
      expect(page).to have_selector('h2', text: 'Pousadas Disponíveis')
      expect(page).to have_selector('#city-menu')
      cities = all('#city-menu a').map(&:text)
      expect(cities).to eq(['Belo Horizonte', 'Bonito', 'Manaus', 'Marataízes'])
    end
  end 
  it 'and sees the logdes when clicking on the name of the city' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    owner3 = Owner.create!(name: 'Márcia Gomes', email: 'mrsgomes@gmail.com', password: '123456')
    owner4 = Owner.create!(name: 'Laís Nunes', email: 'lanunes@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: false, disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'available', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    lodge3 = Lodge.create!(name: 'Jardim de espelhos', address: 'Alameda Tuiuiú, 58', neighborhood: 'Horizonte', city: 'Bonito', state: 'MS',
                           country: 'Brasil', zip_code: '58961-222', description: 'Pousada em contato com a natureza', bedrooms: 15, 
                           max_guests: 45, pets: false, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'available', email: 'jardimdosespelhos@gmail.com', phone_number: '59987458523', 
                           corporate_name: 'Pantanal Resorts LTDA', cnpj: '57568391000162', payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.', owner: owner3)
    lodge4 = Lodge.create!(name: 'Morada do Curupira', address: 'Avenida Solimões, 789',  neighborhood: 'Seringueiras', city: 'Manaus', state: 'AM', 
                           country: 'Brasil', zip_code: '19845-666', description: 'Pousada rodeada pela maior floresta do mundo', bedrooms: 12, 
                           max_guests: 44, pets: true, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'available', email: 'moradadocurupira@gmail.com', phone_number: '75984596231', 
                           corporate_name: 'Amazonia pousadas SA', cnpj: '76773869000130', payment_method: "Cartão de crédito, Cartão de débito, Pix e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido fumar no local. Não aceitamos cheques.', owner: owner4)

    #Act
    visit root_path
    click_on 'Belo Horizonte'

    #Assert
    expect(page).to have_content 'Recanto do Sol'
    expect(page).not_to have_content 'Morada do Curupira'  
  end

  it 'and sees the logdes from a city in alphabetical order' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    owner3 = Owner.create!(name: 'Márcia Gomes', email: 'mrsgomes@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Belo Horizonte',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'available', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: false, disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'available', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    lodge3 = Lodge.create!(name: 'Jardim de espelhos', address: 'Alameda Tuiuiú, 58', neighborhood: 'Horizonte', city: 'Belo Horizonte', state: 'MS',
                           country: 'Brasil', zip_code: '58961-222', description: 'Pousada em contato com a natureza', bedrooms: 15, 
                           max_guests: 45, pets: false, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'available', email: 'jardimdosespelhos@gmail.com', phone_number: '59987458523', 
                           corporate_name: 'Pantanal Resorts LTDA', cnpj: '57568391000162', payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.', owner: owner3)

    #Act
    visit root_path
    click_on 'Belo Horizonte'

    #Assert
    lodge_names = all('.lodge-name').map(&:text)
    expect(lodge_names).to eq(lodge_names.sort)
  end

  it 'and there are no registered lodges' do
    #Act
    visit root_path 
    #Assert
    expect(page).to have_content 'Não existem pousadas cadastradas'
  end 
end
