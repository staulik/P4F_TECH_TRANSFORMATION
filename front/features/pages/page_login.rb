class CriaScreenLogin < SitePrism::Page

  include RSpec::Mocks::ExampleMethods::ExpectHost
  include RSpec::Matchers 

  set_url 'http://automationpractice.com/index.php?controller=authentication&back=my-account'

  
        
  #################  CAMPOS DE INPUT  ######################
  element :input_email,                       "#email"  
  element :input_pswd,                        '#passwd'
  
   #################  BOTÕES  ######################
   element :btn_sign,                        "#SubmitLogin" 
     
     
   ################## MENSAGENS #######################
   element :msg_erro_login, :xpath,                "/html/body/div/div[2]/div/div[3]/div/div[1]/p"
   

   
   #expected_elements :input_email, :input_pswd, :btn_sign, :msg_erro_login

  
    def usuario_inexistente
      execute_script "window.scrollBy(0,100)"
      input_email.set(DADOS[:user_inexistente][:email])
      input_pswd.set(DADOS[:user_inexistente][:senha])
      btn_sign.highlight
      btn_sign.click 
   end

    def user_existente
      execute_script "window.scrollBy(0,300)"
      wait_until_input_email_visible
      input_email.highlight
      input_email.set(DADOS[:cad_user][:user])
      input_pswd.highlight
      input_pswd.set(DADOS[:cad_user][:_password])
      btn_sign.highlight
      btn_sign.click 
    end

    def valida_user_logado
      view_user.highlight
      user_front = view_user.text
      pp expect((DADOS[:cad_user][:user])).to eql (user_front)
       
    end
end