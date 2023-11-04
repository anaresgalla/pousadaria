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
    Lodge.create!(name:'Pousada do Mar', headline:'Praia dos Coqueiros', 
                  full_address:'Avenida Beira Mar 1500, Marataízes - ES, Brasil', description: 'Pousada em frente à praia')
    Lodge.create!(name:'Recanto do Sol', headline:'Serra do Cipó', 
                  full_address: 'Rua das Emas 17, Belo Horizonte - MG, Brasil', description: 'Pousada com vista para a serra')

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
