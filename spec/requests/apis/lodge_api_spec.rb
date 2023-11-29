require 'rails_helper'

describe 'Lodge API' do
  context 'GET /api/v1/lodges' do
    it 'and list all the lodges successfully' do
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
                             check_in: '17:00', check_out: '14:00', status: 'Ativa', 
                             email: 'recantodosol@gmail.com', phone_number: '38985694512',
                             corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', 
                             payment_method: "Cartão de débito, Dinheiro e Pix", 
                             policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
      
      #Act
      get '/api/v1/lodges'

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.first['name']).to eq('Pousada do Mar')
      expect(json_response.first['city']).to eq('Marataízes')
      expect(json_response.second['name']).to eq('Recanto do Sol')
      expect(json_response.second['neighborhood']).to eq('Serrinha')
      expect(json_response.length).to eq 2
      expect(json_response.first.keys).not_to include('created_at')
      expect(json_response.first.keys).not_to include('updated_at')
      expect(json_response.first.keys).not_to include('owner_id')
      expect(json_response.second.keys).not_to include('created_at')
      expect(json_response.second.keys).not_to include('updated_at')
      expect(json_response.second.keys).not_to include('owner_id')
    end

    it 'list all lodges ordered by name' do
      #Arrange
      owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
      owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                              password: '123456')                
      lodge1 = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes',
                              state: 'ES', country: 'Brasil', zip_code: '12345-985', 
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
                              check_in: '17:00', check_out: '14:00', status: 'Ativa', 
                              email: 'recantodosol@gmail.com', phone_number: '38985694512',
                              corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', 
                              payment_method: "Cartão de débito, Dinheiro e Pix", 
                              policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
      #Act
      get '/api/v1/lodges'

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response [0]['name']).to eq 'Pousada do Mar'
      expect(json_response [1]['name']).to eq 'Recanto do Sol'
    end

    it 'uses lodge names as filters' do
      #Arrange
      owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', 
                              password: '123456')
      owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', 
                              password: '123456')                
      lodge1 = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', 
                              neighborhood: 'Coqueiros', city: 'Marataízes',
                              state: 'ES', country: 'Brasil', zip_code: '12345-985', 
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
                              check_in: '17:00', check_out: '14:00', status: 'Ativa', 
                              email: 'recantodosol@gmail.com', phone_number: '38985694512',
                              corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', 
                              payment_method: "Cartão de débito, Dinheiro e Pix", 
                              policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
      search_params = {name: 'Pousada'}
      
      #Act
      get '/api/v1/lodges/', params: search_params

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]['name']).to eq 'Pousada do Mar'
      expect(json_response).not_to eq 'Recanto do Sol'
    end

    it 'return empty if there is no lodge' do
      #Arrange
      #Act
      get '/api/v1/lodges'

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'and raise internal error' do
      #Arrange
      allow(Lodge).to receive(:all).and_raise(ActiveRecord::ConnectionNotEstablished)
      
      #Act
      get '/api/v1/lodges'
      
      #Assert
      expect(response).to have_http_status 500
    end   
  end 

  context 'GET /api/v1/lodges/1' do
    it 'successfully with the average rate' do
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
                          area: '15 m²', max_guests: 2, standard_overnight: '150,00 BRL', 
                          bathroom: 'Sim', balcony: 'Sim', ac: 'Sim', tv: 'Sim', 
                          closet: 'Sim', disabled_facilities: 'Sim', safe: 'Não', 
                          vacant: 'Disponível', lodge: lodge)
      user = User.create!(name: 'Ana', email: 'ana@email.com', 
                          password: '123456', cpf: '27111653025')
      booking1 = Booking.create!(check_in: 1.day.ago, check_out: 2.days.from_now, 
                                guests: 2, room: room, user: user, status: 5)
      booking2 = Booking.create!(check_in: 3.day.ago, check_out: 4.days.from_now, 
                                guests: 2, room: room, user: user, status: 5)
      review = Review.create!(rating: 5, comment: 'Excelente pousada!', booking: booking1)
      review2 = Review.create!(rating: 3, comment: 'Boa pousada!', booking: booking2)
      allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
      
      #Act
      get "/api/v1/lodges/#{lodge.id}" 

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Pousada do Mar')
      expect(json_response['city']).to eq('Marataízes')
      expect(json_response['email']).to eq('pousadadomar@gmail.com')
      expect(json_response['average']).to eq 4.0
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end
  
    it 'fail if lodge not found' do
      #Arrange
      #Act
      get '/api/v1/lodges/999999'
      #Assert
      expect(response.status).to eq 404
    end

    it 'sees the info of a lodge with no ratings' do
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

      #Act
      get "/api/v1/lodges/#{lodge.id}"

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)     
      expect(json_response['name']).to eq 'Pousada do Mar'     
      expect(json_response.keys).not_to include 'owner_id'
      expect(json_response['average']).to eq ''
    end
  end

  context 'GET /api/v1/rooms/:room_id/check_availability/' do
    it 'returns the price of the room if it is available' do
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
                          vacant: true, lodge: lodge)
      booking_params = {id: room.id, start_date: Date.today, end_date: 10.days.from_now, guests: 2 } 

      #Act
      get "/api/v1/lodges/check_availability", params: booking_params

      #Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['total_price']).to eq 1650.0
    end
  
    it 'does not return the price of the room because it is unavailable' do
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
                          vacant: true, lodge: lodge)
      user = User.create!(name: 'Ana', email: 'ana@email.com', 
                          password: '123456', cpf: '27111653025')
      booking = Booking.create!(check_in: Date.today, check_out: 10.days.from_now, 
                                guests: 2, room: room, user: user, status: 5)
      booking_params = {id: room.id, start_date: Date.today, end_date: 10.days.from_now, guests: 2 } 

      #Act
      get "/api/v1/lodges/check_availability", params: booking_params

      #Assert
      expect(response.status).to eq 422
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Reserva não pode ser feita. Data indisponível ou número de hóspedes é maior que o máximo.')
    end
  end
end 