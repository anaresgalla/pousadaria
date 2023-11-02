require 'rails_helper'

describe 'User visits homepage' do 
  it 'and see the name of the app' do 
    # Arrange
    # Act
    visit root_path 

    # Assert
    expect(page).to have_content('Pousadas')
    #expect(page).to have_link('Pousadas', href: root_path)
  end 

  it 'and see the registered lodges' do 
    #Arrange
    Lodge.create!(name:'Pousada do Mar', headline:'Praia dos Coqueiros', city:'Marataízes',
                  state: 'ES', country: 'Brasil', description: 'Pousada em frente à praia')
    Lodge.create!(name:'Recanto do Sol', headline:'Serra do Cipó', city:'Belo Horizonte',
                  state: 'MG', country: 'Brasil', description: 'Pousada com vista para a serra')

    #Act
    visit(root_path)

    #Assert
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

  # it 'and there are no registered lodges' do
  #   #Arrange

  #   #Act
  #   visit(root_path)
  #   #Assert
  #   expect(page).to have_content('Não existem galpões cadastrados')
  # end 
end
