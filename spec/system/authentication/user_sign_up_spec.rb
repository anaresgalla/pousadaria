describe 'User authentication' do
  it 'successfully' do
    #Act
    visit root_path
    click_on 'Entrar como Hóspede'
    click_on 'Sign up'
    fill_in 'Nome', with: 'Elisa'
    fill_in 'E-mail', with: 'elisa@email.com'
    fill_in 'Cpf', with: 91556704070
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Sign up'

    #Assert
    expect(page).to have_content 'Boas vindas! Seu cadastro foi feito com sucesso.'
    expect(page).to have_content 'elisa@email.com'
    expect(page).to have_content 'Elisa'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'Elisa'
  end 
end
