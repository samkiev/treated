require 'selenium-webdriver'
class CheckoutPage
include PageObject



in_iframe(:name => 'klarna-checkout-iframe') do |frame|

    text_field(:email, :class => 'fieldset--challenge__editor--email', :frame => frame)
    text_field(:postal_code, :class => 'fieldset--challenge__editor--postal-code', :frame => frame)
    button(:continue, :class => 'cui__highlighted-button', :frame => frame)
    select_list(:title, :name => 'billing_address.title')
    text_field(:first_name, :class => 'fieldset--billing-address__editor--given-name', :frame => frame)
    text_field(:last_name, :class => 'fieldset--billing-address__editor--family-name', :frame => frame)
    text_field(:address, :class => 'fieldset--billing-address__editor--street-address', :frame => frame)
    text_field(:birth_day, :class => 'fieldset--billing-address__editor--date-of-birth-day', :frame => frame)
    text_field(:birth_month, :class => 'fieldset--billing-address__editor--date-of-birth-month', :frame => frame)
    text_field(:birth_year, :class => 'fieldset--billing-address__editor--date-of-birth-year', :frame => frame)
    text_field(:phone, :class => 'fieldset--billing-address__editor--phone', :frame => frame)
    button(:buy_now, :class => 'is-enabled', :frame => frame)
   # button(:buy_now, :id => 'buy-button', :frame => frame)
    div(:preview, :class => 'is-visible')

end

  def checkout_payment
    wait_until {self.email?}
      self.email = 'm@m.m'
      self.postal_code = 'N7 0AB'
    continue
    sleep 2
    wait_until {self.buy_now?}
      buy_now

    if preview?
      self.title = 'Miss'
      self.first_name = 'Customer name'
      self.last_name = 'Customer last name'
      self.address = 'Customer address'
      self.birth_day = '12'
      self.birth_month = '12'
      self.birth_year = '1990'
      self.phone = '+489456123'
      #continue
    end


  end
end