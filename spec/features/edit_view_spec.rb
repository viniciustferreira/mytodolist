require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'
require 'date'
include Common

RSpec.describe 'Edit a task' do
  before(:all) do
    if !MultiTask.where(description: "testing edit").exists?
      task = MultiTask.new(
        {
          title: 'edit',
          start_date: Time.now,
          end_date:   Time.now + 10*60,
          description: "testing edit",
          priority: 10,
          frequency: 1
        }
      )
      task.save
    end
  end

  it 'changes all data from a existing multi_task' do
    task_id = MultiTask.where(description: 'testing edit').first.id
    date = Date.new(2017,01,01)
    visit "/multi_tasks/#{task_id}/edit"

    fill_in 'Title', with: 'Edit test passed'
    select_date 'multi_task_start_date', date
    select_date 'multi_task_end_date'  , date
    fill_in 'Description', with: 'passed editing'
    fill_in 'Priority', with: 9
    select 1, from: 'multi_task_frequency'
    click_button 'Update'

    expect(page).to have_content("Tarefa atualizada com sucesso.")
  end
end
