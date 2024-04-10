class ModalComponent < ViewComponent::Base
  def initialize(title: nil, description: nil, text_button: 'Button')
    @title = title
    @description = description
    @text_button = text_button
  end
end
