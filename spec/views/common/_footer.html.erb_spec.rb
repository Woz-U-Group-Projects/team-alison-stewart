require 'rails_helper'

describe 'common/_footer.html.erb' do
  it 'should render' do
    expect{ render partial: 'common/footer' }.not_to raise_error
  end
end
