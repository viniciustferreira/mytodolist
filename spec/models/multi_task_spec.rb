require 'rails_helper'

RSpec.describe MultiTask, type: :model do
  before(:each) do
    @parameters = {
      start_date: Time.now,
      end_date:   Time.now + 10*60,
      description: "teste",
      priority: 10,
      frequency: 1 
    }
  end

  it "misses all parameters" do
    @multitask = MultiTask.new
    expect(@multitask).not_to be_valid
  end

  it "misses the begin date" do
    params = @parameters
    params[:start_date] = nil

    @multitask = MultiTask.new(params)
    expect(@multitask).not_to be_valid
  end

  it "misses the description" do
    params = @parameters
    params[:description] = nil

    @multitask = MultiTask.new(params)
    expect(@multitask).not_to be_valid
  end

  it "creates a object with priority 1 (less prioritary)" do
    params = @parameters
    params[:priority] = nil

    @multitask = MultiTask.new(params)
    expect(@multitask).to be_valid
  end

  it "creates a object with frequency 999 (only one time)" do
    params = @parameters
    params[:frequency] = nil

    @multitask = MultiTask.new(params)
    expect(@multitask).to be_valid
  end

  it "creates a object with finished as false" do
    @multitask = MultiTask.new(@parameters)
    expect(@multitask).to be_valid
  end
end
