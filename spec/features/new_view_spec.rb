require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'
require 'date'
include Common

RSpec.describe 'creation of a new task' do

  it 'creates a new task' do
    date = Date.new(2017,01,01)
    visit '/multi_tasks/new'
    fill_in 'Title', with: 'Teste'
    select_date 'multi_task_start_date', date
    select_date 'multi_task_end_date'  , date
    fill_in 'Description', with: 'testing'
    fill_in 'Priority', with: 9
    select 1, from: 'multi_task_frequency'

    click_button 'Create'
    expect(page).to have_content("Tarefa criada com sucesso.")

  end
  it 'creates a new subtask' do
  end
end
