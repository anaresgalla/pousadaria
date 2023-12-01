require 'rails_helper'

describe 'Owner edits a room' do 
  it 'from the details page' do
    #Arrange
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                          password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                          neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                          country: 'Brasil', zip_code: '12345-985',
                          description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                          check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                          payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    
    #Act 
    visit root_path
    login_as owner 
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
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                          password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                          neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                          country: 'Brasil', zip_code: '12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                          check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                          payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    #Act 
    visit root_path
    login_as owner
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
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                          password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                          neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                          country: 'Brasil', zip_code: '12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                          check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                          payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Sim', lodge: lodge)

    #Act 
    visit root_path
    login_as owner
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
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                           password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                           password: '123456')
    lodge1 = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                           neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                           country: 'Brasil', zip_code: '12345-985', 
                           description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                          check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                          payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
    lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', 
                           neighborhood: 'Serrinha', city: 'Belo Horizonte', state: 'MG', 
                           country: 'Brasil', zip_code: '77345-000', 
                           description: 'Pousada com vista para a serra', bedrooms: 6,
                           max_guests: 20, pets: 'Não', disabled_facilities: 'Rampas de acesso', 
                           check_in: '17:00', check_out: '14:00', status: 'Inativa', 
                           email: 'recantodosol@gmail.com', phone_number: '38985694512',
                           corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', 
                           payment_method: "Cartão de débito, Dinheiro e Pix", 
                           policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge1)

    #Act 
    visit root_path
    login_as owner2 
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    
    #Assert 
    expect(page).not_to have_button 'Editar'
  end

  it 'and the owner sets special pricings' do
    #Arrange
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                          password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                          neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                          country: 'Brasil', zip_code: '12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                          check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                          payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Sim', lodge: lodge)

    #Act 
    visit root_path
    login_as owner
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Atualizar Preços'
    fill_in 'Preço Especial', with: '100'
    fill_in 'Data Inicial', with: 1.day.ago.strftime("%d/%m/%Y")
    fill_in 'Data Final', with: 1.day.from_now.strftime("%d/%m/%Y")
    click_on 'Cadastrar Preço Especial'

    #Assert
    expect(page).to have_content 'Preço especial cadastrado com sucesso!' 
    expect(page).to have_content '100'
  end

  it 'and uploads pictures of the room' do
    #Arrange 
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                          password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                          neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                          check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                          payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    
    #Act 
    visit root_path
    login_as owner
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Editar'
    attach_file('room[pictures][]',
                [Rails.root.join('spec/images/room.jpg')])
    click_on 'Enviar'

    #Assert 
    expect(room.reload.pictures.size).to eq 1
  end

  it 'and deletes pictures of the room' do
    $VERBOSE = nil
    #Arrange 
    owner = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                          password: '123456')
    lodge = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                          neighborhood: 'Coqueiros', city: 'Marataízes',
                          state: 'ES', country: 'Brasil', zip_code: '12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, 
                          max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                          check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                          corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                          payment_method: "Cartão de crédito, Pix", 
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)
    room = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', 
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    room.pictures.attach(io: File.open('spec/images/room.jpg'),
                          filename: 'room.jpg', content_type: 'image/jpg')
    room.save

    # Act
    login_as owner
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Pérola Negra'
    click_on 'Excluir'

    # Assert
    expect(page).to have_content 'Foto removida com sucesso.'
    expect(lodge.reload.pictures.size).to eq 0
  end
end
