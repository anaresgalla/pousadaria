require 'rails_helper'

describe 'Room API' do
  context 'GET /api/v1/lodges/:lodge_id/rooms' do
    it 'lists all the vacant rooms in a lodge successfully' do
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
      room1 = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15', max_guests: 2,
                           standard_overnight: '150,00', bathroom: true, balcony: true, ac: true, tv: true, 
                           closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge)
      room2 = Room.create!(name: 'Iemanjá', description: 'Quarto com praia reservada', area: '20', max_guests: 4,
                           standard_overnight: '350,00', bathroom: true, balcony: true, ac: true, tv: true, 
                           closet: true, disabled_facilities: true, safe: true, vacant: false, lodge: lodge)
      room3 = Room.create!(name: 'Boitatá', description: 'Quarto com os fundos para a mata', area: '15', max_guests: 3,
                           standard_overnight: '180,00', bathroom: true, balcony: true, ac: true, tv: true, 
                           closet: true, disabled_facilities: false, safe: false, vacant: true, lodge: lodge)
      
      #Act
      get "/api/v1/lodges/#{lodge.id}/rooms" 

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.first['name']).to eq('Pérola Negra')
      expect(json_response.second['name']).to eq('Boitatá')
      expect(json_response).not_to eq('Iemanjá')
      expect(json_response.length).to eq 2
      expect(json_response.first.keys).not_to include('created_at')
      expect(json_response.first.keys).not_to include('updated_at')
      expect(json_response.second.keys).not_to include('created_at')
      expect(json_response.second.keys).not_to include('updated_at')
    end

    it 'there are no rooms in a lodge' do
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
      
      #Act
      get "/api/v1/lodges/#{lodge.id}/rooms" 

      #Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
    
    it 'and raise internal error' do
      #Arrange
      allow(Lodge).to receive(:find).and_raise(ActiveRecord::ConnectionNotEstablished)
      
      #Act
      get '/api/v1/lodges/1/rooms'
      
      #Assert
      expect(response).to have_http_status 500
    end   
  end 
end 
