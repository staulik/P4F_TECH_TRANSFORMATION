Dir[File.join(File.dirname(__FILE__), '../pages/*_page.rb')].each { |file| require file }


module CapybaraExtension
  def jquery(event)
    base.jquery(event)
  end
  def highlight(color="yellow")
    base.highlight(color)
  end
end

module CapybaraSeleniumExtension
  def jquery(evento)
    dir_atual = File.expand_path File.dirname(__FILE__) # pega o caminho do arquivo
    js = File.read("#{dir_atual}/jquery.min.js") # ler o arquivo jquery
    driver.execute_script(js)
    driver.execute_script("$(arguments[0]).trigger(\"#{evento}\")", native)
  end
  def highlight(color)
    dir_atual = File.expand_path File.dirname(__FILE__) # pega o caminho do arquivo
    js = File.read("#{dir_atual}/jquery.min.js") # ler o arquivo jquery
    driver.execute_script(js)
    driver.execute_script("$(arguments[0]).css({'border':'5px solid #{color}'});", native)
  end
end

# importando funcao para dentro do framework
::Capybara::Selenium::Node.send :include, CapybaraSeleniumExtension
::Capybara::Node::Element.send :include, CapybaraExtension


module PageObjects

  def screen_cadastro
    @cadastro ||= ScreenCadastro.new
  end
  
  def screen_login
    @login ||= CriaScreenLogin.new
  end

  def wait_for_pageload(count=5)
    init = 0
    until (page.execute_script("return document.readyState").eql?('complete') || init == count)
      sleep 1
      print init += 1
      raise ArgumentError.new("Page not loaded fully") if init == count
    end
  end

  def clique(element)

    # Mapeia o elemento e verifica se o elemento existe e visivel.
    element_exists?(element)
    scroll_to (element)
    element.highlight
    element.click

  rescue => ex
    log ex.message
    log ex.backtrace
    print "Tentando via javascript"

  end

  def element_exists?(element)

    if element.visible?
        log element.inspect
        true
    end

  rescue => ex
    log ex.message
    log ex.backtrace
    print "Tela #{page.title} - Elemento '#{element.inspect}' não encontrado."
    false

  end

end


