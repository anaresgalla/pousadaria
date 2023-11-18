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
    click_on 'Sign up'

    #Assert
    expect(page).to have_content 'Boas vindas! Seu cadastro foi feito com sucesso.'
    expect(page).to have_content 'elisa@email.com'
    expect(page).to have_content 'Elisa'
    expect(page).to have_button 'Sair'
    owner = Owner.last
    expect(owner.name).to eq 'Elisa'
  end 

  it 'and is redirected to new lodge register' do
    #Act
    visit root_path
    click_on 'Entrar como Proprietário'
    click_on 'Sign up'
    fill_in 'Name', with: 'Elisa'
    fill_in 'Email', with: 'elisa@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password ', with: '123456'
    click_on 'Sign up'

    #Assert
    expect(page).to have_content 'Boas vindas! Seu cadastro foi feito com sucesso.'
    expect(page).to have_content 'elisa@email.com'
    expect(page).to have_content 'Elisa'
    expect(page).to have_button 'Sair'
    owner = Owner.last
    expect(owner.name).to eq 'Elisa'
    expect(current_path).to eq new_lodge_path
  end

  it 'and cannot go to another page until a new logde is registered' do
    #Act
    visit root_path
    click_on 'Entrar como Proprietário'
    click_on 'Sign up'
    fill_in 'Name', with: 'Elisa'
    fill_in 'Email', with: 'elisa@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    #Act 
    visit root_path

    #Assert
    expect(current_path).to eq new_lodge_path
    expect(page).to have_button 'Sair'
  end
end