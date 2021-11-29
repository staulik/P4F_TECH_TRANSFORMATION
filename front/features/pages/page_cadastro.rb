class ScreenCadastro < SitePrism::Page

  include RSpec::Mocks::ExampleMethods::ExpectHost
  include RSpec::Matchers 

  set_url 'http://automationpractice.com/index.php?controller=authentication&back=my-account'
  
         
  #################  CAMPOS DE INPUT  ######################
    element :input_email_create,                "#email_create"  
    element :input_first_name,                  "#customer_firstname"
    element :input_last_name,                   "#customer_lastname"
    element :input_cad_pswd,                    "#passwd"
    element :input_cad_company,                 "#company"
    element :input_cad_address,                 "#address1"
    element :input_cad_city,                    "#city"
    element :input_post_code,                   "#postcode"
    element :input_mobile_phone,                "#phone_mobile"
    element :input_address_alias,               '#alias'
    
    

    ############### CAMPOS DE SELECAO  #############################
    element :seleciona_cad_state,                 "#uniform-id_state"


    ################# CAMPOS DE VISUALIZAÇÃO ########################33
    element :view_id_Fname,                     "#firstname"
    element :view_user,                         ".account"
   

    ###############  BOTÕES   ######################33
    element :btn_create_account,    "#SubmitCreate"    
    element :btn_radio_MR,          "#id_gender1"
    element :btn_register,          "#submitAccount"
    element :btn_logout,            ".logout"
    
    

    ################# METODOS #####################################
 def cadastrar_usuario
   input_email_create.send_keys(Faker::Internet.email)
   save_user
   btn_create_account.click 
   execute_script "window.scrollBy(0,200)"
   wait_until_btn_radio_MR_visible
   btn_radio_MR.click
   input_first_name.send_keys(Faker::Name.first_name)
   @pega_first_name = input_first_name.send_keys(Faker::Name.first_name).value
   input_last_name.send_keys(Faker::Name.last_name)
   @pega_last_name = input_last_name.send_keys(Faker::Name.last_name).value
   input_cad_pswd.send_keys(DADOS[:cad_user][:_password])
   input_cad_company.send_keys(DADOS[:cad_user][:_company])
   input_cad_address.send_keys(DADOS[:cad_user][:_address])
   input_cad_city.send_keys(DADOS[:cad_user][:_city])
   find(:xpath,'/html/body/div/div[2]/div/div[3]/div/div/form/div[2]/p[7]/div/select/option[11]').click
   execute_script "window.scrollBy(0,700)"
   input_post_code.send_keys(DADOS[:cad_user][:_post_cod])
   input_mobile_phone.send_keys(Faker::PhoneNumber.cell_phone)
   @take_first_name = view_id_Fname.value
   input_address_alias.send_keys(:clear).set("Endereco do #{@take_first_name}")
   btn_register.click
   
   sleep 2
 end
  
  def save_user
    d = YAML::load_file('C:/temp/P4F/front/features/support/massa/users.yml') #Load
    d[:cad_user][:user] = input_email_create.value  #Modify
    File.open('C:/temp/P4F/front/features/support/massa/users.yml', 'w') {|f| f.write d.to_yaml } #Store
  end


 def area_logada
  #concatena nome + sobre-nome
  take_fname_lname = @pega_first_name + " " + @pega_last_name
  view_user.highlight
  user_front = view_user.text
  pp expect(take_fname_lname).to eql (user_front)
  wait_until_btn_logout_visible
  btn_logout.click
  end
end