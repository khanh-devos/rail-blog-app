require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before(:each) do
    @user = User.create(name: 'John Doe')
    render
  end

  it 'displays the header with "Recent Posts"' do
    expect(rendered).to have_selector('h2', text: 'Recent Posts')
  end

  it 'renders the user partial' do
    expect(rendered).to render_template(partial: '_user')
  end

  it 'displays a "Back to users" link' do
    expect(rendered).to have_link('Back to users', href: users_path)
  end
end
