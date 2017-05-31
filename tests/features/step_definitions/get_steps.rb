#encoding: utf-8
                                                                             
Quando(/^faço uma consulta$/) do                    
    @result = HTTParty.get("https://ninjarest.herokuapp.com/users", :verify => false)        
end                                                                          
                                                                             
Então(/^o código de resposta deve ser "([^"]*)"$/) do |status_code|                 
  expect(@result.response.code).to eql status_code
end                                                                          
                                                                             
Então(/^o sistema retorna uma lista de usuarios cadastrados$/) do            
  res = @result.parsed_response
  expect(res).not_to be_empty
  res.each do |u|
      expect(u).to have_key('id')
      expect(u).to have_key('name')
      expect(u).to have_key('email')
      expect(u).to have_key('password')
    end
 end                                                                          

 Dado(/^que eu tenho um usuário cadastrado$/) do
# @user = {
#      :id => '5927826635023a0004b4213e',
#      :name => 'Nicolas Mitchell' ,
#      :email => 'wilfrid@harris.net',
#      :password =>'root'
#  }
list =  @result = HTTParty.get("https://ninjarest.herokuapp.com/users", :verify => false)  
@user = list.parsed_response.sample
@user_id = @user['id']
end

Então(/^faço a consulta desse usuário$/) do  
    @result = HTTParty.get("https://ninjarest.herokuapp.com/users/#{@user_id}", :verify => false)    
end

Quando(/^faço a consulta desse usuário por email$/) do
    @result = HTTParty.get('https://ninjarest.herokuapp.com/users',
    query: { email: @user['email'] },
    :verify => false
    )       
    #bacalhau 
    a = Array.new
    a.push(@user)
    @user = a
end


Então(/^o sistema retorna os dados desse usuario$/) do
    #puts @user
    #puts @result.parsed_response
    #simulacao de bug no response
    #@result.parsed_response['email'] = 'secundario@email.com'
    expect(@result.parsed_response).to eql @user
end


##404
Dado(/^que o usuário não está cadastrado$/) do
  @user_id = Faker::Crypto.md5
end

Então(/^vejo a mensagem "([^"]*)"$/) do |msg|
  expect(@result.parsed_response['message']).to eql msg
end