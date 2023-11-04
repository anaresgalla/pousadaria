require 'rails_helper'

describe 'Owner edits a lodge' do 
  it 'from the details page' do
    #Arrange
    lodge = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                          disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                          cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", policies: 'Proibido fumar no local. Silêncio a partir das 22h.')
    
    #Act 
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Editar'

    #Assert
    expect(page).to have_content 'Editar Pousada'
    expect(page).to have_field('Nome', with: 'Pousada do Mar')
    expect(page).to have_field('CNPJ', with: '08945909000124')
    expect(page).to have_field('E-mail', with: 'pousadadomar@gmail.com')
  end 

  it 'com sucesso' do
    #Arrange 
    lodge = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                          disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                          cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", policies: 'Proibido fumar no local. Silêncio a partir das 22h.')
    
    #Act 
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Editar'
    fill_in 'Nome', with: 'Pousada das Sereias'
    click_on 'Enviar'

    #Assert --> garantir que os dados foram modificados e voltar pro show do galpão para cf os dados
    expect(page).to have_content 'Pousada atualizada com sucesso!'
    expect(page).to have_content 'Nome: Pousada das Sereias'
  end

  it 'e mantém os campos obrigatórios' do
    #Arrange
    lodge = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                          description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                          disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                          email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                          cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", policies: 'Proibido fumar no local. Silêncio a partir das 22h.')

    #Act 
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #Assert 
    expect(page).to have_content 'Não foi possível atualizar a pousada.'
  end
end