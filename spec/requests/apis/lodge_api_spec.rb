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
      get "/api/v1/lodges"

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
      get "/api/v1/lodges/", params: search_params

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
      get "/api/v1/lodges"

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
      get "/api/v1/lodges"
      
      #Assert
      expect(response).to have_http_status 500
    end   
  end 
end 