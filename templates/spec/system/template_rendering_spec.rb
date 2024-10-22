# frozen_string_literal: true

require 'solidus_starter_frontend_spec_helper'

RSpec.describe 'Template rendering', type: :system do
  after do
    Capybara.ignore_hidden_elements = true
  end

  before do
    Capybara.ignore_hidden_elements = false

    Spree::Store.create!(
      code: 'spree',
      name: 'My Spree Store',
      url: 'spreestore.example.com',
      mail_from_address: 'test@example.com'
    )
  end

  it 'layout should have canonical tag referencing site url' do
    visit root_path

    expect(find('link[rel=canonical]')[:href]).to eql('http://spreestore.example.com/')
  end

  # TODO: Fill in the examples below and move the implementation to a single
  # tag helper that can handle all these scenarios.
  # Q: What should we do with the `trailing_slash` configuration option. NOTHING
  def solidus_canonical_tag(url, allowed_params: [:keywords, :page, :search, :taxon])
  end

  it "renders a canonical tag for products index page with keywords query string" do
    create(:product_in_stock, name: 'Solidus Mug', price: 10.00)

    visit products_path(keywords: 'solidus')

    expect(page).to have_content('Solidus Mug')

    expect(
      find('link[rel=canonical]')[:href]
    ).to eql('http://spreestore.example.com/products/?keywords=solidus')
  end

  it "renders a canonical tag for the products index with a taxon query string" do
    create(:product_in_stock, name: 'Solidus Mug', price: 10.00)

    visit products_path(keywords: 'solidus', taxon: taxon.id)

    expect(page).to have_content('Solidus Mug')

    expect(
      find('link[rel=canonical]')[:href]
    ).to eql("http://spreestore.example.com/products/?keywords=solidus&taxon=#{taxon.id}")

  end

  it "renders a canonical tag for taxon pages with a search filter query string"

  it "renders a canonical tag for taxon pages with multiple pages of search results"
end
