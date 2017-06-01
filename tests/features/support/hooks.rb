

Before ('@new_user') do

name = Faker::Superhero.name
@request = {
  name: name,
  email: Faker::Internet.free_email(name), 
  password: 'test#123'
}

HTTParty.post(
      'https://ninjarest.herokuapp.com/users',
      :body=> @request.to_json,
      :headers=> {'Content-Type' => 'application/json'}, 
      :verify => false
    )

result = HTTParty.get(
    'https://ninjarest.herokuapp.com/users',
    query: { email: @request[:email] },
    :verify => false
    )

    @user = result.parsed_response.first

end