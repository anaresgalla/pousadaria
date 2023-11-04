# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
lodge1 = Lodge.create!(name: 'Pousada do Mar', headline: 'Praia dos Coqueiros', full_address: 'Avenida Beira Mar, Marataízes - ES, Brasil. CEP: 12345-985', 
                       description: 'Pousada em frente à praia', bedrooms: 5, max_guests: 12, pets: 'yes', 
                       disabled_facilities: 'Menu em Braile', check_in: '15:00', check_out: '12:00', status: 'available', 
                       email: 'pousadadomar@gmail.com', phone_number: '28985647114', corporate_name: 'Almeida e Filhos LTDA',
                       cnpj: '08945909000124', payment_method: "Cartão de crédito, Pix", policies: 'Proibido fumar no local. Silêncio a partir das 22h.')

lodge2 = Lodge.create!(name: 'Recanto do Sol', headline: 'Serra do Cipó', full_address: 'Rua das Emas, 13, Belo Horizonte - MG, Brasil. CEP: 77345-000', 
                       description: 'Pousada com vista para a serra', bedrooms: 6, max_guests: 20, pets: 'no', 
                       disabled_facilities: 'Rampas de acesso', check_in: '17:00', check_out: '14:00', status: 'unavailable', 
                       email: 'recantodosol@gmail.com', phone_number: '38985694512', corporate_name: 'Fernandes e Oliveira LTDA',
                       cnpj: '91241057000138', payment_method: "Cartão de débito, Dinheiro e Pix", policies: 'Silêncio a partir das 22h. Proibido visitas.')

lodge3 = Lodge.create!(name: 'Jardim de espelhos', headline: 'Reserva Natural', full_address: 'Alameda Tuiuiú, 58, Bonito - MS, Brasil. CEP: 58961-222', 
                       description: 'Pousada em contato com a natureza', bedrooms: 15, max_guests: 45, pets: 'no', 
                       disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', check_out: '13:00', status: 'available', 
                       email: 'jardimdosespelhos@gmail.com', phone_number: '59987458523', corporate_name: 'Pantanal Resorts LTDA', 
                       cnpj: '57568391000162', payment_method: "Cartão de crédito, Cartão de débito e Dinheiro", 
                       policies: 'Silêncio a partir das 22h. Proibido visitas. Proibido fumar no local. Não aceitamos cheques.')

lodge4 = Lodge.create!(name: 'Morada do Curupira', headline: 'Floresta Amazônica no quintal', full_address: 'Avenida Solimões, 789, Manaus - AM, Brasil. CEP: 19845-666', 
                       description: 'Pousada rodeada pela maior floresta do mundo', bedrooms: 12, max_guests: 44, pets: 'yes', 
                        disabled_facilities: 'Rampas de acesso, banheiros adaptados', check_in: '18:00', check_out: '13:00', status: 'available', 
                        email: 'moradadocurupira@gmail.com', phone_number: '75984596231', corporate_name: 'Amazonia pousadas SA', 
                        cnpj: '76773869000130', payment_method: "Cartão de crédito, Cartão de débito, Pix e Dinheiro", 
                        policies: 'Silêncio a partir das 22h. Proibido fumar no local. Não aceitamos cheques.')

lodge5 = Lodge.create!(name:'Casa do Velho Chico', headline:'Serra da Canastra', full_address:'Rua do Marmelo, 861, São Roque de Minas - MG, Brasil. CEP: 54321-012', 
                       description: 'Pousada na beira do rio São Francisco', bedrooms: 4, max_guests: 32, pets: 'no', 
                        disabled_facilities: 'Rampas de acesso', check_in: '16:00', check_out: '14:00', status: 'unavailable', 
                        email: 'casadovelhochico@gmail.com', phone_number: '31987412589', corporate_name: 'José Pinheiro Gomes LTDA', 
                        cnpj: '02727106000117', payment_method: "Pix e Dinheiro", 
                        policies: 'Silêncio a partir das 22h. Proibido fumar no local.')