class QuestionsPage
  include PageObject

  labels :switch_button, class: 'choose-box__label_first-child'
  labels :check_boxes, class: 'checkboxQuestion-holder'
  labels :mult_check_boxes, class: 'multichoice-answer-checkbox-label'
  label(:agree_check, :class => "checkbox-block-label ")
  button(:submit, :class => 'green-btn')
  text_fields(:text_fields, :class => 'freetext-input')
  spans(:drop_downs, :xpath => "//span/span[.='Please choose your answer']/..")
  # elements :options, :option, xpath: "//option[.='Please choose your answer']"

  def confirm_question
    submit
  end

  def go_through_ddls
    drop_downs_elements.each do |span|
      span.scroll_into_view
      span.when_visible.click
      div_element(class:'select-options').when_visible.list_item_element(class:'choose-box__option_negative').link_element.click
    end
  end

  def fill_text_fields
    unless text_fields_elements.empty?
        text_fields_elements.each do |element|
        element.send_keys 'Some answer'
      end
    end
  end

  def click_question_buttons()
    switch_button_elements.map do |parent|
      parent.scroll_into_view
      parent.when_present.click
    end
  end

  def check_all_checkboxes()
    check_boxes_elements.map do |box|
      box.click
    end
    mult_check_boxes_elements.map do |index|
      index.click
    end
    agree_check_element.click
  end





  def confirm_alert_window
      @current_page.click_on_confirm_button
  end

end