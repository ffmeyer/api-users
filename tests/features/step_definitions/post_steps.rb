#encoding: utf-8

Dado(/^que eu tenho um novo usuário$/) do
  name = Faker::Superhero.name
  @request = {
    name: name,
    email: Faker::Internet.free_email(name), 
    password: 'test#123'
  }
end

Quando(/^faco o cadastro$/) do
   @result = HTTParty.post(
      'https://ninjarest.herokuapp.com/users',
      :body=> @request.to_json,
      :headers=> {'Content-Type' => 'application/json'}, 
      :verify => false
    )
end

  Então(/^vejo este usuário cadastrado no sistema$/) do
    result = HTTParty.get('https://ninjarest.herokuapp.com/users',
    query: { email: @request[:email] },
    :verify => false
    )  
    expect(result.parsed_response.first['id']).not_to be_empty
    expect(result.parsed_response.first['name']).to eql @request[:name]
    expect(result.parsed_response.first['email']).to eql @request[:email]
    expect(result.parsed_response.first['password']).to eql @request[:password]
end