require 'rails_helper'

describe 'User sees ratings of a lodge' do
  it 'and sees the average score' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
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
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    user = User.create!(name: 'Ana', email: 'ana@email.com', 
                        password: '123456', cpf: '27111653025')
    booking1 = Booking.create!(check_in: 1.day.ago, check_out: 5.days.from_now, 
                              guests: 2, room: room, user: user, status: 5)
    booking2 = Booking.create!(check_in: 1.week.ago, check_out: 2.days.ago, 
                              guests: 2, room: room, user: user, status: 5)
    booking3 = Booking.create!(check_in: 2.week.ago, check_out: 10.days.ago, 
                              guests: 2, room: room, user: user, status: 5)
    review1 = Review.create!(rating: 5, comment: 'Excelente pousada!', reply: 'Muito obrigada!', booking: booking1)
    review2 = Review.create!(rating: 3, comment: 'Pensei que o quarto fosse mais arejado.', reply: 'Obrigada pela sugestão.', booking: booking2)
    review3 = Review.create!(rating: 4, comment: 'Lugar bastante agradável.', reply: 'Obrigada, volte sempre!', booking: booking3)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    visit root_path

    #Assert
    expect(page).to have_content 'Nota média: 4.0'
  end 

  it 'and there is no score' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                        neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                        country: 'Brasil', zip_code: '12345-985', 
                        description: 'Pousada em frente à praia', bedrooms: 5, 
                        max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                        check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                        email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                        corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                        payment_method: "Cartão de crédito, Pix", 
                        policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act
    visit root_path
    click_on 'Pousada do Mar'

    #Assert
    expect(page).to have_content 'Não possui avaliações ainda.'
  end 

  it 'and sees the last three reviews of a lodge' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
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
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    user = User.create!(name: 'Ana', email: 'ana@email.com', 
                        password: '123456', cpf: '27111653025')
    booking1 = Booking.create!(check_in: 1.day.ago, check_out: 5.days.from_now, 
                              guests: 2, room: room, user: user, status: 5)
    booking2 = Booking.create!(check_in: 1.week.ago, check_out: 2.days.ago, 
                              guests: 2, room: room, user: user, status: 5)
    booking3 = Booking.create!(check_in: 2.week.ago, check_out: 10.days.ago, 
                              guests: 2, room: room, user: user, status: 5)
    booking4 = Booking.create!(check_in: 2.months.ago, check_out: 1.month.ago, 
                              guests: 2, room: room, user: user, status: 5)
    review1 = Review.create!(rating: 5, comment: 'Excelente pousada!', reply: 'Muito obrigada!', booking: booking1)
    review2 = Review.create!(rating: 3, comment: 'Pensei que o quarto fosse mais arejado.', reply: 'Obrigada pela sugestão.', booking: booking2)
    review3 = Review.create!(rating: 4, comment: 'Lugar bastante agradável.', reply: 'Obrigada, volte sempre!', booking: booking3)
    review4 = Review.create!(rating: 2, comment: 'Não recomendo', reply: 'Sinto muito.', booking: booking4)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    visit root_path
    click_on 'Pousada do Mar'

    #Assert
    expect(page).not_to have_content 'Excelente pousada!'
    expect(page).to have_content 'Nota (0-5): 3'
    expect(page).to have_content 'Não recomendo'
  end 

  it 'and sees all the reviews of a lodge on a separate page' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
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
                        area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                        bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                        closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                        vacant: 'Disponível', lodge: lodge)
    user = User.create!(name: 'Ana', email: 'ana@email.com', 
                        password: '123456', cpf: '27111653025')
    booking1 = Booking.create!(check_in: 1.day.ago, check_out: 5.days.from_now, 
                              guests: 2, room: room, user: user, status: 5)
    booking2 = Booking.create!(check_in: 1.week.ago, check_out: 2.days.ago, 
                              guests: 2, room: room, user: user, status: 5)
    booking3 = Booking.create!(check_in: 2.week.ago, check_out: 10.days.ago, 
                              guests: 2, room: room, user: user, status: 5)
    booking4 = Booking.create!(check_in: 2.months.ago, check_out: 1.month.ago, 
                              guests: 2, room: room, user: user, status: 5)
    review1 = Review.create!(rating: 5, comment: 'Excelente pousada!', reply: 'Muito obrigada!', booking: booking1)
    review2 = Review.create!(rating: 3, comment: 'Pensei que o quarto fosse mais arejado.', reply: 'Obrigada pela sugestão.', booking: booking2)
    review3 = Review.create!(rating: 4, comment: 'Lugar bastante agradável.', reply: 'Obrigada, volte sempre!', booking: booking3)
    review4 = Review.create!(rating: 2, comment: 'Não recomendo', reply: 'Sinto muito.', booking: booking4)
    allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')

    #Act
    visit root_path
    click_on 'Pousada do Mar'
    click_on 'Ver todas as avaliações'

    #Assert
    expect(page).to have_content 'Excelente pousada!'
    expect(page).to have_content 'Nota (0-5): 3'
    expect(page).to have_content 'Não recomendo'
    expect(page).to have_content 'Obrigada, volte sempre!'
  end 

  it 'and there are no reviews' do
    #Arrange
    owner = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                          password: '123456')
    lodge = Lodge.create(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                        neighborhood: 'Coqueiros', city: 'Marataízes', state: 'ES', 
                        country: 'Brasil', zip_code: '12345-985', 
                        description: 'Pousada em frente à praia', bedrooms: 5, 
                        max_guests: 12, pets: 'Sim', disabled_facilities: 'Menu em Braile', 
                        check_in: '15:00', check_out: '12:00', status: 'Ativa', 
                        email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                        corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', 
                        payment_method: "Cartão de crédito, Pix", 
                        policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner)

    #Act
    visit root_path
    click_on 'Pousada do Mar'

    #Assert
    expect(page).to have_content 'Ainda não há avaliações.'
  end 
end 