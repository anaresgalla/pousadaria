
owner1 = Owner.create!(name: 'Mônica Resende', email: 'monica@email.com', password: '123456')
owner2 = Owner.create!(name: 'Rosana Alves', email: 'rosana@email.com', password: '123456')
owner3 = Owner.create!(name: 'Márcia Gomes', email: 'marcia@email.com', password: '123456')
owner4 = Owner.create!(name: 'Laís Nunes', email: 'lais@email.com', password: '123456')
owner5 = Owner.create!(name: 'Maria Nascimento', email: 'maria@email.com', password: '123456')
owner6 = Owner.create!(name: 'Leandro Mesquita', email: 'leandro@email.com', password: '123456')
owner7 = Owner.create!(name: 'Marina Magalhães', email: 'marina@email.com', password: '123456')
owner8 = Owner.create!(name: 'Luis Silva', email: 'luis@email.com', password: '123456')

lodge1 = Lodge.create!(name: 'Pousada Pé na Areia', address: 'Avenida Beira Mar, 1500', neighborhood: 'Geribá', 
                       city: 'Búzios', state: 'RJ', country: 'Brasil', zip_code: '28950-001', 
                       description: 'Pousada em frente à praia', bedrooms: 4, max_guests: 12, pets: true, 
                       disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', 
                       status: 'Ativa', email: 'pousadapenaareia@gmail.com', phone_number: '22985647114', 
                       corporate_name: 'Almeida e Filhos LTDA', cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", 
                       policies: 'Proibido fumar no local. Silêncio a partir das 22h.', owner: owner1)
lodge1.pictures.attach(io: File.open('spec/images/lodge/buzios1.jpg'),
                       filename: 'buzios1.jpg', content_type: 'image/jpg')
lodge1.save
lodge2 = Lodge.create!(name: 'Estalagem da Serra', address: 'Rua das Emas, 13', neighborhood: 'Colméias', 
                       city: 'Tiradentes', state: 'MG', country: 'Brasil', zip_code: '36300-320', 
                       description: 'Pousada com vista para a serra', bedrooms: 4, max_guests: 10, pets: false, 
                       disabled_facilities: 'Rampas de acesso', check_in: '17:00', 
                       check_out: '14:00', status: 'Inativa', email: 'estalagemdaserra@gmail.com', 
                       phone_number: '32985694512', corporate_name: 'Alves e Jorge LTDA', cnpj: '91241057000138', 
                       payment_method: "Cartão de débito, Dinheiro e Pix", 
                       policies: 'Silêncio a partir das 22h. Proibido visitas.', owner: owner2)
# lodge2.pictures.attach(io: File.open('spec/images/lodge/tira.jpg'),
#                        filename: 'tira.jpg', content_type: 'image/jpg')
# lodge2.save
lodge3 = Lodge.create!(name: 'Jardim dos Espelhos', address: 'Alameda Tuiuiú, 58', neighborhood: 'Horizonte', 
                       city: 'Bonito', state: 'MS', country: 'Brasil', zip_code: '79240-000', 
                       description: 'Pousada em contato com a natureza', bedrooms: 10, max_guests: 35, pets: false, 
                       disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                       check_out: '13:00', status: 'Ativa', email: 'jardimdosespelhos@gmail.com', 
                       phone_number: '67987458523', corporate_name: 'Pantanal Resorts LTDA', cnpj: '57568391000162', 
                       payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                       policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.', 
                       owner: owner3)
# lodge3.pictures.attach(io: File.open('spec/images/lodge/bonito.jpg'),
#                        filename: 'bonito.jpg', content_type: 'image/jpg')
# lodge3.save
lodge4 = Lodge.create!(name: 'Morada do Curupira', address: 'Avenida Solimões, 789',  neighborhood: 'Seringueiras', 
                       city: 'Manaus', state: 'AM', country: 'Brasil', zip_code: '69047-010', 
                       description: 'Pousada rodeada pela maior floresta do mundo', bedrooms: 8, max_guests: 24, 
                       pets: true, disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', 
                       check_out: '13:00', status: 'Ativa', email: 'moradadocurupira@gmail.com', phone_number: '92984596231', 
                       corporate_name: 'Amazonia Pousadas SA', cnpj: '76773869000130', 
                       payment_method: "Cartão de crédito, Cartão de débito, Pix e Dinheiro", 
                       policies: 'Silêncio a partir das 22h. Proibido fumar no local. Não aceitamos cheques.', owner: owner4)
# lodge4.pictures.attach(io: File.open('spec/images/lodge/manaus.jpg'),
#                        filename: 'manaus.jpg', content_type: 'image/jpg')
# lodge4.save
lodge5 = Lodge.create!(name:'Casa do Velho Chico', address:'Rua do Marmelo, 861', neighborhood:'Canastra', 
                       city: 'São Roque de Minas', state: 'MG', country: 'Brasil', zip_code: '37928-000', 
                       description: 'Pousada na beira do rio São Francisco', bedrooms: 4, max_guests: 15, 
                       pets: false, disabled_facilities: 'Rampas de acesso', check_in: '16:00', check_out: '14:00', 
                       status: 'Inativa', email: 'casadovelhochico@gmail.com', phone_number: '37987412589', 
                       corporate_name: 'Sao Francisco SA', cnpj: '02727106000117', payment_method: "Pix e Dinheiro", 
                       policies: 'Silêncio a partir das 22h. Proibido fumar no local.', owner: owner5)
# lodge5.pictures.attach(io: File.open('spec/images/lodge/velho.jpg'),
#                        filename: 'velho.jpg', content_type: 'image/jpg')
# lodge5.save
lodge6 = Lodge.create!(name:'Jam Session Inn', address:'Avenida Independência, 458', neighborhood:'Aeroporto', 
                       city: 'Juiz de Fora', state: 'MG', country: 'Brasil', zip_code: '36321-012', 
                       description: 'Pousada pra quem curte um som legal!', bedrooms: 5, max_guests: 20, 
                       pets: false, disabled_facilities: 'Rampas de acesso', check_in: '12:00', check_out: '14:00', 
                       status: 'Ativa', email: 'jamsession@gmail.com', phone_number: '32998512589', 
                       corporate_name: 'Mesquita e Resgalla LTDA', cnpj: '56127836000106', 
                       payment_method: "Pix e Dinheiro", policies: 'Silêncio a partir das 22h. Proibido fumar no local.', 
                       owner: owner6)
# lodge6.pictures.attach(io: File.open('spec/images/lodge/jf.jpg'),
#                        filename: 'jf.jpg', content_type: 'image/jpg')
# lodge6.save
lodge7 = Lodge.create!(name:'Além do Sol', address:'Avenida das Conchas, 458', neighborhood:'Ferradura', 
                       city: 'Búzios', state: 'RJ', country: 'Brasil', zip_code: '28950-050', 
                       description: 'Pousada ensolarada!', bedrooms: 4, max_guests: 12, 
                       pets: false, disabled_facilities: 'Rampas de acesso', check_in: '12:00', check_out: '14:00', 
                       status: 'Ativa', email: 'alemdosol@email.com', phone_number: '22998512589', 
                       corporate_name: 'Sunset Enterprises LTDA', cnpj: '00127836000106', 
                       payment_method: "Pix, Dinheiro, Cartão de crédito", 
                       policies: 'Proibido fumar no local.', owner: owner7)
lodge7.pictures.attach(io: File.open('spec/images/lodge/buzios.jpg'),
                       filename: 'buzios.jpg', content_type: 'image/jpg')
lodge7.save
lodge8 = Lodge.create!(name:'Chalé Tropicano', address:'Avenida São Salvador, 458', neighborhood:'Pelourinho', 
                       city: 'Salvador', state: 'BA', country: 'Brasil', zip_code: '41745-970', 
                       description: 'Pousada ensolarada!', bedrooms: 4, max_guests: 12, 
                       pets: false, disabled_facilities: 'Rampas de acesso', check_in: '12:00', check_out: '14:00', 
                       status: 'Ativa', email: 'chale@email.com', phone_number: '77998512589', 
                       corporate_name: 'Cajueiros LTDA', cnpj: '12457836000106', 
                       payment_method: "Pix, Dinheiro, Cartão de crédito", 
                       policies: 'Não aceitamos cheques.', owner: owner8)
# lodge8.pictures.attach(io: File.open('spec/images/lodge/bahia.jpg'),
#                        filename: 'bahia.jpg', content_type: 'image/jpg')
# lodge8.save

room1 = Room.create!(name: 'Castelo de Areia', description: 'Quarto de frente para o mar', area: '15', max_guests: 2,
                     standard_overnight: '150,00', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge1)
# room1.pictures.attach([{io: File.open('spec/images/room/areia.png'), filename: 'areia.png', content_type: 'image/png'}])
# room1.save
room2 = Room.create!(name: 'Água Salgada', description: 'Quarto mais amplo', area: '20', max_guests: 4,
                     standard_overnight: '350,00', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: true, vacant: false, lodge: lodge1)
# room2.pictures.attach([{io: File.open('spec/images/room/shell.jpg'), filename: 'shell.jpg', content_type: 'image/jpg'}])
# room2.save
room3 = Room.create!(name: 'Maré Cheia', description: 'Quarto com praia reservada', area: '15', max_guests: 3,
                     standard_overnight: '180,00', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: false, safe: false, vacant: true, lodge: lodge1)
# room3.pictures.attach([{io: File.open('spec/images/room/casal.jpg'), filename: 'casal.jpg', content_type: 'image/jpg'}])
# room3.save
room4 = Room.create!(name: 'Inconfidência', description: 'Quarto com varanda sobre o rio', area: '21', max_guests: 4,
                     standard_overnight: '500,00', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: false, lodge: lodge2)
# room4.pictures.attach([{io: File.open('spec/images/room/terra.jpg'), filename: 'terra.jpg', content_type: 'image/jpg'}])
# room4.save
room5 = Room.create!(name: 'Calango', description: 'Quarto com vista para a serra', area: '13', max_guests: 3,
                     standard_overnight: '200,00', bathroom: true, balcony: false, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: false, lodge: lodge2)
# room5.pictures.attach([{io: File.open('spec/images/room/yellow.jpg'), filename: 'yellow.jpg', content_type: 'image/jpg'}])
# room5.save
room6 = Room.create!(name: 'Buriti', description: 'Quarto com os fundos para a mata', area: '25', max_guests: 5,
                     standard_overnight: '400,00', bathroom: true, balcony: false, ac: true, tv: false, 
                     closet: false, disabled_facilities: true, safe: false, vacant: true, lodge: lodge3)
# room6.pictures.attach([{io: File.open('spec/images/room/verdeescuro.jpg'), filename: 'verdeescuro.jpg', content_type: 'image/jpg'}])
# room6.save
room7 = Room.create!(name: 'Onça Pintada', description: 'Quarto amplo com varanda', area: '30', max_guests: 6,
                     standard_overnight: '450,00', bathroom: 'true', balcony: true, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: false, vacant: false, lodge: lodge3)
# room7.pictures.attach([{io: File.open('spec/images/room/brasil2.jpeg'), filename: 'brasil2.jpeg', content_type: 'image/jpeg'}])
# room7.save
room8 = Room.create!(name: 'Rio Antigo', description: 'Quarto com vista para o Rio São Francisco', area: '17', max_guests: 2,
                     standard_overnight: '250,00', bathroom: true, balcony: false, ac: true, tv: true, 
                     closet: true, disabled_facilities: true, safe: true, vacant: true, lodge: lodge5)
# room8.pictures.attach([{io: File.open('spec/images/room/pastel.jpeg'), filename: 'pastel.jpeg', content_type: 'image/jpeg'}])
# room8.save
room9 = Room.create!(name: 'Água Corrente', description: 'Quarto amplo com varanda', area: '25', max_guests: 5,
                     standard_overnight: '350,00', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: false, disabled_facilities: true, safe: false, vacant: false, lodge: lodge5)
# room9.pictures.attach([{io: File.open('spec/images/room/cinza.jpg'), filename: 'cinza.jpg', content_type: 'image/jpg'}])
# room9.save
room10 = Room.create!(name: 'Boto Rosa', description: 'Quarto com varanda palafita', area: '20', max_guests: 4,
                     standard_overnight: '350,00', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: false, disabled_facilities: true, safe: false, vacant: false, lodge: lodge4)
# room10.pictures.attach([{io: File.open('spec/images/room/brasil.jpg'), filename: 'brasil.jpg', content_type: 'image/jpg'}])
# room10.save 
room11 = Room.create!(name: 'Boitatá', description: 'Quarto com vista para a mata', area: '20', max_guests: 4,
                     standard_overnight: '350,00', bathroom: true, balcony: true, ac: true, tv: true, 
                     closet: false, disabled_facilities: true, safe: false, vacant: false, lodge: lodge4)
# room11.pictures.attach([{io: File.open('spec/images/room/verde.jpg'), filename: 'verde.jpg', content_type: 'image/jpg'}])
# room11.save 
room12 = Room.create!(name: 'Beatles', description: 'Quarto com varanda', area: '17', max_guests: 2,
                      standard_overnight: '120,00', bathroom: true, balcony: true, ac: true, tv: true, 
                      closet: false, disabled_facilities: true, safe: false, vacant: true, lodge: lodge6) 
# room12.pictures.attach([{io: File.open('spec/images/room/beatles.jpg'), filename: 'beatles.jpg', content_type: 'image/jpg'}])
# room12.save
room13 = Room.create!(name: 'ACDC', description: 'Quarto amplo', area: '21', max_guests: 2,
                      standard_overnight: '120,00', bathroom: true, balcony: true, ac: true, tv: true, 
                      closet: false, disabled_facilities: true, safe: false, vacant: true, lodge: lodge6) 
# room13.pictures.attach([{io: File.open('spec/images/room/acdc.jpg'), filename: 'acdc.jpg', content_type: 'image/jpg'}])
# room13.save
room14 = Room.create!(name: 'Ensolarado', description: 'Quarto de frente para o mar', area: '15', max_guests: 2,
                      standard_overnight: '150,00', bathroom: true, balcony: true, ac: true, tv: true, 
                      closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge7)
# room14.pictures.attach([{io: File.open('spec/images/room/boho.jpg'), filename: 'boho.jpg', content_type: 'image/jpg'}])
# room14.save
room15 = Room.create!(name: 'Bardot', description: 'Quarto de frente para o mar', area: '15', max_guests: 3,
                      standard_overnight: '150,00', bathroom: true, balcony: true, ac: true, tv: true, 
                      closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge7)
# room15.pictures.attach([{io: File.open('spec/images/room/lilas.jpg'), filename: 'lilas.jpg', content_type: 'image/jpg'}])
# room15.save
room16 = Room.create!(name: 'Ilê Ayiê', description: 'Quarto com maior axé', area: '21', max_guests: 5,
                      standard_overnight: '250,00', bathroom: true, balcony: true, ac: true, tv: true, 
                      closet: true, disabled_facilities: true, safe: false, vacant: true, lodge: lodge7)
# room16.pictures.attach([{io: File.open('spec/images/room/africa.jpg'), filename: 'africa.jpg', content_type: 'image/jpg'}])
# room16.save

special_pricing1 = SpecialPricing.create!(start_date: 1.day.ago, end_date: 1.day.from_now, price: 200, room: room1)
special_pricing2 = SpecialPricing.create!(start_date: 2.days.from_now, end_date: 10.days.from_now, price: 100, room: room1)
special_pricing3 = SpecialPricing.create!(start_date: 2.weeks.from_now, end_date: 3.weeks.from_now, price: 75, room: room1)
special_pricing4 = SpecialPricing.create!(start_date: 1.month.from_now, end_date: 2.months.from_now, price: 250, room: room1)
special_pricing5 = SpecialPricing.create!(start_date: 1.day.ago, end_date: 1.day.from_now, price: 200, room: room15)
special_pricing6 = SpecialPricing.create!(start_date: 2.days.from_now, end_date: 10.days.from_now, price: 100, room: room15)
special_pricing7 = SpecialPricing.create!(start_date: 2.weeks.from_now, end_date: 3.weeks.from_now, price: 75, room: room13)
special_pricing8 = SpecialPricing.create!(start_date: 1.month.from_now, end_date: 2.months.from_now, price: 250, room: room13)
