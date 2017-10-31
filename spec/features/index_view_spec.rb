require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'
require 'date'
include Common

RSpec.describe 'Show all tasks and subtasks' do

  it 'shows all the tasks with the subtasks' do
    visit '/multi_tasks'

    expect(page).to have_content("Descrição")
    expect(page).to have_content("Data de inicio")
    expect(page).to have_content("Data de fim")
  end
end
