class MainPage
  include PageObject

  #wait_for_expected_title 'Treated.com: Order your meds online | 80% faster'
  page_url 'https://staging.treated.com'
  text_field(:login_mail, :name => 'Email')
  button(:knock_knock, :css => '.loader-box>button' )
  text_field(:product_name, :id => 'main-search')
  link(:all_link, :class => 'for-desctop')
  button(:submit,:class => "icon-search")

  def login_with(login_mail)
    self.login_mail = login_mail
    knock_knock
    #wait_until(10, 'bla') { @current_page.title.include? 'Treated.com: Order your meds online | 80% faster' }
  end
end