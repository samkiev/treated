class ProductPage
  include PageObject

  button(:read_more,:class => "b-green-btn")
  button(:order_now,:class => "b-green-btn")

end