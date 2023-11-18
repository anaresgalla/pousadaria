# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

owner1 = Owner.create!(name: 'Rogério Sampaio', email: 'rsampaio123@gmail.com', password: '123456')
owner2 = Owner.create!(name: 'Carla Mendonça', email: 'carsampa@gmail.com', password: '123456')
owner3 = Owner.create!(name: 'Márcia Gomes', email: 'mrsgomes@gmail.com', password: '123456')
owner4 = Owner.create!(name: 'Laís Nunes', email: 'lanunes@gmail.com', password: '123456')
owner5 = Owner.create!(name: 'Monica Resende', email: 'monicares@gmail.com', password: '123456')
owner6 = Owner.create!(name: 'Leandro Mesquita', email: 'leandro@gmail.com', password: '123456')

lodge1 = Lodge.create!(name: 'Pousada do Mar', address: 'Avenida Beira Mar, 1500', neighborhood: 'Coqueiros', city: 'Marataízes',
                       state: 'ES', country: 'Brasil', zip_code: '12345-985', description: 'Pousada em frente à praia', bedrooms: 5, 
                       max_guests: 12, pets: true, disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                       status: 'Ativa', email: 'pousadadomar@gmail.com', phone_number: '28985647114', 
                       corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                       policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)

lodge2 = Lodge.create!(name: 'Recanto do Sol', address: 'Rua das Emas, 13', neighborhood: 'Serrinha', city: 'Belo Horizonte',
                       state: 'MG', country: 'Brasil', zip_code: '77345-000', description: 'Pousada com vista para a serra', bedrooms: 6,
                       max_guests: 20, pets: false, disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', 
                       status: 'Inativa', email: 'recantodosol@gmail.com', phone_number: '38985694512',
                       corporate_name: 'Fernandes e Oliveira LTDA', cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", 
                       policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)

lodge3 = Lodge.create!(name: 'Jardim de espelhos', address: 'Alameda Tuiuiú, 58', neighborhood: 'Horizonte', city: 'Bonito', state: 'MS',
                       country: 'Brasil', zip_code: '58961-222', description: 'Pousada em contato com a natureza', bedrooms: 15, 
                       max_guests: 45, pets: false, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                       check_out: '13:00', status: 'Ativa', email: 'jardimdosespelhos@gmail.com', phone_number: '59987458523', 
                       corporate_name: 'Pantanal Resorts LTDA', cnpj: '57568391000162', payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                       policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.', owner: owner3)

lodge4 = Lodge.create!(name: 'Morada do Curupira', address: 'Avenida Solimões, 789',  neighborhood: 'Seringueiras', city: 'Manaus', state: 'AM', 
                       country: 'Brasil', zip_code: '19845-666', description: 'Pousada rodeada pela maior floresta do mundo', bedrooms: 12, 
                        max_guests: 44, pets: true, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                        check_out: '13:00', status: 'Ativa', email: 'moradadocurupira@gmail.com', phone_number: '75984596231', 
                        corporate_name: 'Amazonia pousadas SA', cnpj: '76773869000130', payment_method: "Cartão de crédito, Cartão de débito, Pix e Dinheiro", 
                        policies: 'Silêncio a partir das 22h. Proibido fumar no local. Não aceitamos cheques.', owner: owner4)

lodge5 = Lodge.create!(name:'Casa do Velho Chico', address:'Rua do Marmelo, 861', neighborhood:'Canastra', city: 'São Roque de Minas', state: 'MG', 
                       country: 'Brasil', zip_code: '54321-012', description: 'Pousada na beira do rio São Francisco', bedrooms: 4, max_guests: 32, 
                       pets: false, disabled_facilities: 'Rampas de acesso', check_in: '16:00', check_out: '14:00', status: 'Inativa', 
                       email: 'casadovelhochico@gmail.com', phone_number: '31987412589', corporate_name: 'José Pinheiro Gomes LTDA', cnpj: '02727106000117', 
                       payment_method: "Pix e Dinheiro", policies: 'Silêncio a partir das 22h. Proibido fumar no local.', owner: owner5)

lodge6 = Lodge.create!(name:'Jam Session Inn', address:'Avenida Independência, 458', neighborhood:'Centro', city: 'Belo Horizonte', state: 'MG', 
                       country: 'Brasil', zip_code: '34321-012', description: 'Pousada pra quem curte um som legal!', bedrooms: 5, max_guests: 20, 
                       pets: false, disabled_facilities: 'Rampas de acesso', check_in: '12:00', check_out: '14:00', status: 'Ativa', 
                       email: 'jamsession@gmail.com', phone_number: '31998512589', corporate_name: 'Mesquita e Resgalla LTDA', cnpj: '56127836000106', 
                       payment_method: "Pix e Dinheiro", policies: 'Silêncio a partir das 22h. Proibido fumar no local.', owner: owner6)

room1 = Room.create!(name: 'Pérola Negra', description: 'Quarto de frente para o mar', area: '15', max_guests: 2,
                     standard_overnight: '150,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge1)
room2 = Room.create!(name: 'Iemanjá', description: 'Quarto com praia reservada', area: '20', max_guests: 4,
                     standard_overnight: '350,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: true, vacant: false, lodge: lodge1)
room3 = Room.create!(name: 'Boitatá', description: 'Quarto com os fundos para a mata', area: '15', max_guests: 3,
                     standard_overnight: '180,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: false, safe: false, vacant: true, lodge: lodge4)
room4 = Room.create!(name: 'Onça Pintada', description: 'Quarto com varanda sobre o rio', area: '21', max_guests: 5,
                     standard_overnight: '500,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: false, lodge: lodge3)
room5 = Room.create!(name: 'Calango', description: 'Quarto com vista para a serra', area: '13', max_guests: 3,
                     standard_overnight: '200,00 BRL', bathroom: true, balcony: false, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: false, lodge: lodge2)
room6 = Room.create!(name: 'Jacaré do Papo Amarelo', description: 'Quarto com os fundos para a mata', area: '25', max_guests: 5,
                     standard_overnight: '400,00 BRL', bathroom: true, balcony: false, ac: true, tv: false, 
                     closet: false, disabled_facilities: true, safe: false, vacant: true, lodge: lodge3)
room7 = Room.create!(name: 'Bromélia', description: 'Quarto amplo com varanda', area: '30', max_guests: 6,
                     standard_overnight: '450,00 BRL', bathroom: 'true', balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: false, lodge: lodge2)
room8 = Room.create!(name: 'Rio Antigo', description: 'Quarto com vista para o Rio São Francisco', area: '17', max_guests: 2,
                     standard_overnight: '250,00 BRL', bathroom: true, balcony: false, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: true, vacant: true, lodge: lodge5)
room9 = Room.create!(name: 'Água Corrente', description: 'Quarto amplo com varanda', area: '25', max_guests: 5,
                     standard_overnight: '350,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: false, disabled_facilities: true, safe: false, vacant: false, lodge: lodge5)
room10 = Room.create!(name: 'Boto Rosa', description: 'Quarto com varanda palafita', area: '20', max_guests: 4,
                     standard_overnight: '350,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: false, disabled_facilities: true, safe: false, vacant: false, lodge: lodge4) 
room11 = Room.create!(name: 'ACDC', description: 'Quarto com varanda', area: '17', max_guests: 4,
                      standard_overnight: '120,00 BRL', bathroom: true, balcony: true, ac: true, tv: true, 
                      closet: false, disabled_facilities: true, safe: false, vacant: true, lodge: lodge6) 
                      
special_pricing1 = SpecialPricing.create!(start_date: 1.day.ago, end_date: 1.day.from_now, price: 200, room: room1)
special_pricing2 = SpecialPricing.create!(start_date: 2.days.from_now, end_date: 10.days.from_now, price: 100, room: room1)
special_pricing3 = SpecialPricing.create!(start_date: 2.weeks.from_now, end_date: 3.weeks.from_now, price: 75, room: room1)
special_pricing4 = SpecialPricing.create!(start_date: 1.month.from_now, end_date: 2.months.from_now, price: 250, room: room1)
