# README

<h1 align="center">
  Pousadaria
</h1>

## Pousadaria

Por: Ana Resgalla, 2023

Este projeto foi desenvolvido durante o TreinaDev 11, programa oferecido pela Campus Code. 

Pousadaria é uma app para que pessoas possam procurar e reservar quartos em pousadas disponíveis por todo o Brasil.
Tanto proprietários de estabelecimentos quando hóspedes podem se beneficiar da app. 
Além disso, usuários não registrados também têm acesso a algumas informações sobre as pousadas e os quartos.

### Ações de Proprietários
- Registrar pousadas e quartos e preencher informações sobre ambos (limite de 01 pousada por proprietário).
- Gerenciar reservas.
- Estabelecer preços especiais de diárias nos períodos que determinar.
- Gerenciar Check-Ins e Check-Outs.
- Responder avaliações de usuários,
entre outras.

### Ações de Clientes
- Pesquisar por pousadas em todo o Brasil.
- Visualizar informações sobre pousadas ativas e seus quartos.
- Checar a disponibilidade de um quarto em determinado período.
- Realizar reservas.
- Avaliar estabelecimentos,
entre outras.

Versões utilizadas:

Ruby: 3.2.1

Rails: 7.1.1

Default port: `3000`
Em um terminal, utilize *curl* ou utiize *postman*.

## Endpoints API/v1

### Lista de Pousadas Ativas

Method: GET
```sh

# Index
> curl -X GET "http://localhost:3000/api/v1/lodges" | json_pp
> [
   {
      "city" : "Marataízes",
      "zip_code" : "12345-985",
      "max_guests" : 12,
      "disabled_facilities" : "Menu em Braile",
      "payment_method" : "Cartão de crédito, Pix",
      "check_in" : "2000-01-01T15:00:00.000Z",
      "policies" : "Proibido fumar no local. Silêncio a partir das 22h.",
      "email" : "pousadadomar@gmail.com",
      "bedrooms" : 5,
      "name" : "Pousada do Mar",
      "country" : "Brasil",
      "check_out" : "2000-01-01T12:00:00.000Z",
      "cnpj" : "08945909000124",
      "corporate_name" : "Almeida e Filhos LTDA",
      "address" : "Avenida Beira Mar, 1500",
      "neighborhood" : "Coqueiros",
      "phone_number" : "28985647114",
      "description" : "Pousada em frente à praia",
      "id" : 1,
      "pets" : true,
      "status" : "Ativa",
      "state" : "ES"
   }, ...
]

# Index com Pesquisa

> curl -X GET "http://localhost:3000/api/v1/lodges?name=Jam" | json_pp
>[
   {
      "zip_code" : "34321-012",
      "country" : "Brasil",
      "policies" : "Silêncio a partir das 22h. Proibido fumar no local.",
      "email" : "jamsession@gmail.com",
      "corporate_name" : "Mesquita e Resgalla LTDA",
      "payment_method" : "Pix e Dinheiro",
      "city" : "Belo Horizonte",
      "bedrooms" : 5,
      "disabled_facilities" : "Rampas de acesso",
      "address" : "Avenida Independência, 458",
      "check_in" : "2000-01-01T12:00:00.000Z",
      "state" : "MG",
      "description" : "Pousada pra quem curte um som legal!",
      "name" : "Jam Session Inn",
      "pets" : false,
      "neighborhood" : "Centro",
      "status" : "Ativa",
      "phone_number" : "31998512589",
      "check_out" : "2000-01-01T14:00:00.000Z",
      "cnpj" : "56127836000106",
      "max_guests" : 20,
      "id" : 6
   }
]
```
### Pousada Específica 
```sh

# Show

> curl -X GET "http://localhost:3000/api/v1/lodges/6" | json_pp

> {
   "id" : 6,
   "phone_number" : "31998512589",
   "payment_method" : "Pix e Dinheiro",
   "pets" : false,
   "average" : 3.5,
   "name" : "Jam Session Inn",
   "zip_code" : "34321-012",
   "city" : "Belo Horizonte",
   "status" : "Ativa",
   "policies" : "Silêncio a partir das 22h. Proibido fumar no local.",
   "disabled_facilities" : "Rampas de acesso",
   "neighborhood" : "Centro",
   "email" : "jamsession@gmail.com",
   "check_out" : "2000-01-01T14:00:00.000Z",
   "state" : "MG",
   "max_guests" : 20,
   "description" : "Pousada pra quem curte um som legal!",
   "bedrooms" : 5,
   "check_in" : "2000-01-01T12:00:00.000Z",
   "country" : "Brasil",
   "address" : "Avenida Independência, 458"
}
```

### Listar Quartos em uma Pousada

```sh
# Com sucesso

> curl -X GET "http://localhost:3000/api/v1/lodges/6/rooms" | json_pp
> [
   {
      "area" : "17",
      "lodge_id" : 6,
      "name" : "ACDC",
      "ac" : true,
      "description" : "Quarto com varanda",
      "balcony" : true,
      "standard_overnight" : "120,00",
      "max_guests" : 4,
      "tv" : true,
      "disabled_facilities" : true,
      "id" : 11,
      "closet" : false,
      "bathroom" : true,
      "vacant" : true,
      "safe" : false
   }, ...
]
```
### Checar Disponibilidade

```sh
# Com sucesso
>  curl -X GET "http://localhost:3000/api/v1/lodges/check_availability?id=1&start_date=2023-12-01&end_date=2023-12-05&guests=2" | json_pp
> {
   "total_price" : 625
  }
```