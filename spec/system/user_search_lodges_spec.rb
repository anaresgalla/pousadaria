require 'rails_helper'

describe 'User searches for a logde' do
  it 'by its brand name' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: 'Não', disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'Ativa', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    
    #Act
    visit root_path
    fill_in 'Busca:', with: 'Pousada do Mar'
    click_on 'Pesquisar'

    #Assert
    expect(current_path).to eq search_path
    expect(page).to have_content 'Pousada do Mar'
    expect(page).not_to have_content 'Recanto do Sol'
  end

  it 'by the neighborhood' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: 'Não', disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'Ativa', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)

    #Act
    visit root_path
    fill_in 'Busca:', with: 'Serrinha'
    click_on 'Pesquisar'

    #Assert
    expect(current_path).to eq search_path
    expect(page).to have_content 'Recanto do Sol'
    expect(page).not_to have_content 'Pousada do Mar'
  end

  it 'by the city' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: 'Não', disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'Ativa', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    
    #Act
    visit root_path
    fill_in 'Busca:', with: 'Marataízes'
    click_on 'Pesquisar'

    #Assert
    expect(current_path).to eq search_path
    expect(page).to have_content 'Pousada do Mar'
    expect(page).not_to have_content 'Recanto do Sol'
  end

  it 'and sees the results of a search in alphabetical order' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    owner3 = Owner.create!(name: 'Márcia Gomes', email: 'mrsgomes@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Bonito',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: 'Não', disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'Ativa', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    lodge3 = Lodge.create!(name: 'Jardim de espelhos', address: 'Alameda Tuiuiú, 58', neighborhood: 'Horizonte', city: 'Bonito', state: 'MS',
                           country: 'Brasil', zip_code: '58961-222', description: 'Pousada em contato com a natureza', bedrooms: 15, 
                           max_guests: 45, pets: 'Não', disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                           check_out: '13:00', status: 'Ativa', email: 'jardimdosespelhos@gmail.com', phone_number: '59987458523', 
                           corporate_name: 'Pantanal Resorts LTDA', cnpj: '57568391000162', payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.', owner: owner3)

    #Act
    visit root_path
    fill_in 'Busca:', with: 'Bonito'
    click_on 'Pesquisar'

    #Assert
    expect(current_path).to eq search_path
    lodge_names = all('.lodge-name').map(&:text)
    expect(lodge_names).to eq(lodge_names.sort) 
  end

  it 'and is redirected to the lodge page after clicking on its name' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: 'Não', disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'Ativa', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    
    #Act
    visit root_path
    fill_in 'Busca:', with: 'Coqueiros'
    click_on 'Pesquisar'
    click_on 'Pousada do Mar'

    #Assert
    lodge = Lodge.find_by(name: 'Pousada do Mar')
    expect(current_path).to eq lodge_path(lodge)
  end

  it 'and there are no results' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
    lodge1 = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                          status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                           state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: 'Não', disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                           status: 'Ativa', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    
    #Act
    visit root_path
    fill_in 'Busca:', with: 'Centro'
    click_on 'Pesquisar'

    #Assert
    expect(page).to have_content 'Nenhum resultado encontrado para "Centro."'
  end
end
