Dado('que o usuário esteja na pagina de Login') do
  screen_login.load
  page.driver.browser.manage.window.resize_to(1920,1080)
  pp expect(screen_login).to be_loaded
  #pp expect(screen_login).to be_all_there
end

#credenciais inválidas
Quando('fornecer {string} ou {string} inválidos') do |_email, _pswd|
  screen_login.execute_script "window.scrollBy(0,100)"
  screen_login.wait_until_input_email_visible
  screen_login.input_email.highlight
  screen_login.input_email.set(_email).send_keys(:tab)
  screen_login.input_pswd.highlight
  screen_login.input_pswd.set(_pswd).send_keys(:tab)
  screen_login.btn_sign.highlight
  screen_login.btn_sign.click
end
  
Então('ele visualiza a mensagem de alerta {string}') do |msg_alert|
  msg_invalid = screen_login.msg_erro_login.text
  expect(msg_invalid).to eql(msg_alert)
end

#usuário não cadastrado
Quando('fornecer login inexistente') do 
  screen_login.usuario_inexistente
end

Então('seu acesso não é liberado') do
  msg_invalid = screen_login.msg_erro_login.text
  pp expect(msg_invalid).to eql('There is 1 error')
end


Quando('as informacoes validas forem fornecidas') do
  screen_login.user_existente
end

Então('o usuario pode ver que esta logado') do
end