require_relative '../spec_helper'
require_relative '../pages/main_page'
require_relative '../pages/questions_page'
require_relative '../pages/product_page'
require_relative '../pages/checkout_page'
require 'selenium-webdriver'
require 'page-object'
require 'rspec'
require 'yaml'


def wait_for_mainpage_title
  on(MainPage).wait_until { @current_page.title.include? 'Treated.com: Order your meds online | 80% faster' }
end

describe 'Full Scenario' do

  describe 'Search flow:'do
    describe 'Login flow' do
      before :all do
        visit(MainPage).login_with 'm@m.m'
        wait_for_mainpage_title
      end
      it 'should be logged in' do
          expect(@current_page.text).to include 'Simple & Secure Online Treatments'
      end

        @data=YAML::load(File.read("data/data1.yaml"))
        @data.each do |medicine|
          describe "Survey flow with #{medicine}" do
          before :all do
            visit(MainPage)
            on(MainPage).product_name_element.when_visible.send_keys medicine
            on(MainPage).submit
            on(ProductPage).wait_until {@current_page.text.include? medicine}
            on(ProductPage).read_more
            on(ProductPage).order_now
            on(QuestionsPage).wait_until {@current_page.text.include? 'Medical Questions'}
            on(QuestionsPage).click_question_buttons
            on(QuestionsPage).check_all_checkboxes
            on(QuestionsPage).fill_text_fields
            on(QuestionsPage).go_through_ddls
            on(QuestionsPage).confirm_question
            on(QuestionsPage).wait_until {@current_page.title.include? 'Medical consultation'}
            on(CheckoutPage).checkout_payment
            on(CheckoutPage).wait_until {@current_page.text.include? 'Thank you for your order'}
          end

          it " for Medicine #{medicine} result " do
            expect(@current_page.text).to include 'Thank you for your order'
          end
        end

      end
    end

  end
end

