require 'rails_helper'

describe 'Owner edits a lodge' do 
  it 'from the details page' do
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
    
    #Act 
    visit root_path
    login_as owner
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
    
    #Act 
    visit root_path
    login_as owner
    click_on 'Pousada do Mar'
    click_on 'Editar'
    fill_in 'Nome', with: 'Pousada das Sereias'
    click_on 'Enviar'

    #Assert 
    expect(page).to have_content 'Pousada atualizada com sucesso!'
    expect(page).to have_content 'Nome: Pousada das Sereias'
  end

  it 'and leaves mandatory fields empty' do
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

    #Act 
    visit root_path
    login_as owner
    click_on 'Pousada do Mar'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #Assert 
    expect(page).to have_content 'Não foi possível atualizar a pousada.'
  end

  it 'and only the owner can edit their lodge' do
    #Arrange
    owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                          password: '123456')
    owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
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
                          policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)

    #Act 
    visit root_path
    login_as owner2
    click_on 'Pousada do Mar'
    
    #Assert 
    expect(page).not_to have_button 'Editar'
  end

  it 'and uploads pictures of the lodge' do
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
    
    #Act 
    visit root_path
    login_as owner
    click_on 'Pousada do Mar'
    click_on 'Editar'
    attach_file('lodge[pictures][]',
                [Rails.root.join('spec/images/room.jpg')])
    click_on 'Enviar'

    #Assert 
    expect(lodge.reload.pictures.size).to eq 1
  end

  it 'and deletes pictures of the lodge' do
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
    lodge.pictures.attach(io: File.open('spec/images/room.jpg'),
                          filename: 'room.jpg', content_type: 'image/jpg')
    lodge.save

    # Act
    login_as owner
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Excluir'

    # Assert
    expect(page).to have_content 'Foto removida com sucesso.'
    expect(lodge.reload.pictures.size).to eq 0
  end
end
