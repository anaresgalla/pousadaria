describe 'Owner authentication' do
  it 'successfully' do
    #Act
    visit root_path
    click_on 'Entrar como Proprietário'
    click_on 'Sign up'
    fill_in 'Name', with: 'Elisa'
    fill_in 'Email', with: 'elisa@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Criar conta'

    #Assert
    expect(page).to have_content 'Boas vindas! Seu cadastro foi feito com sucesso.'
    expect(page).to have_content 'elisa@email.com'
    expect(page).to have_content 'Elisa'
    expect(page).to have_button 'Sair'
    owner = Owner.last
    expect(owner.name).to eq 'Elisa'
  end 
end