require 'rails_helper'

describe 'User registers a new lodge' do 
  it 'from the homepage' do
    #Act
    visit root_path
    click_on 'Cadastrar Pousada'

    #Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Modo de Pagamento')
  end

  it 'successfully' do
    #Act
    visit root_path
    click_on 'Cadastrar Pousada'
    fill_in 'Nome', with: 'Pousada do Mar'
    fill_in 'Descrição', with: 'Pousada em frente à praia'
    fill_in 'Cabeçalho', with: 'Praia dos Coqueiros'
    fill_in 'CNPJ', with: '08945909000124'
    fill_in 'Endereço', with: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985'
    find('#lodge_pets', visible: true).check
    fill_in 'Número de quartos', with: 5
    fill_in 'Máximo de hóspedes', with: 12
    fill_in 'Acessibilidade para PCD', with: 'Menu em Braile'
    fill_in 'Check In', with: '15:00'
    fill_in 'Check Out', with: '12:00'
    select 'available', from: 'Status'
    fill_in 'E-mail', with: 'pousadadomar@gmail.com'
    fill_in 'Telefone', with: '28985647114'
    fill_in 'Razão Social', with: 'Almeida e Filhos LTDA'
    fill_in 'Modo de Pagamento', with: 'Cartão de crédito, Pix'
    fill_in 'Políticas de Uso', with: 'Proibido fumar no local. Silêncio a partir das 22h.'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Pousada do Mar' 
    expect(page).to have_content 'Pousada em frente à praia'    
    expect(page).to have_content 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985'    
    expect(page).to have_content 'Pousada cadastrada com sucesso!'
  end 

  it 'with incomplete information' do 
    #Arrange 

    #Act
    visit root_path
    #pode colocar somente alguns campos vazios ou todos ou até nenhum pra testar se o formulário vazio vai
    click_on 'Cadastrar Pousada'
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
end