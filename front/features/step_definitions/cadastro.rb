Dado('que o usuário esteja na pagina de cadastro') do
  screen_cadastro.load
  expect(screen_cadastro).to be_loaded
  screen_cadastro.execute_script "window.scrollBy(0,100)"
  page.driver.browser.manage.window.resize_to(1920,1080)
  
  #pp expect(screen_cadastro).to be_all_there
end

#credenciais inválidas
Quando('ele executar o fluxo de cadastro') do
  screen_cadastro.cadastrar_usuario
end


Então('ele é direcionado para a area logada') do
  screen_cadastro.area_logada
 
end

