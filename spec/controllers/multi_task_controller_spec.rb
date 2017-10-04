require 'rails_helper'

RSpec.describe MultiTaskController, type: :controller do
  let(:task) { double }

  describe "GET #new" do
    it "creates 1 multitask " do
      get 'new'
      expect(assigns(:task)).to be_a_new(MultiTask)
    end
  end

  describe "GET #index" do
    let(:task1) { double }
    let(:task2) { double }

    it "returns all tasks" do
      allow(MultiTask).to receive(:all)
        .and_return([task1, task2])

      get 'index'

      expect(assigns(:tasks).size).to be(2)
    end
  end

  describe "PATCH #update" do
    it "updates a task" do
      allow(MultiTask).to receive(:find).with("1")
        .and_return(task)
      allow(task).to receive(:frequency=).with(1)
      allow(task).to receive(:frequency).and_return(1)
      allow(task).to receive(:update).and_return(true)

      patch 'update', { params: { id: 1, task:  { frequency: 1 } } }

      expect(task.frequency).to eq(1)
      expect(flash[:notice]).to eq('Tarefa foi atualizada com sucesso.')
    end

    it "fails to update a task" do
      allow(MultiTask).to receive(:find).with("1")
        .and_return(task)
      allow(task).to receive(:frequency=).with(1)
      allow(task).to receive(:frequency).and_return(0)
      allow(task).to receive(:update).and_return(false)

      patch 'update', { params: { id: 1, task:  { frequency: 1 } } }

      expect(task.frequency).to_not eq(1)
      expect(response).to render_template(:edit)
    end
  end

  describe "GET #show" do

    it "render template" do
      allow(MultiTask).to receive(:find).with("1")
        .and_return(task)

      get 'show', { params: { id: 1 } }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "changes a task " do
    allow(MultiTask).to receive(:find).with("1")
      .and_return(task)

      get 'edit', { params: { id: 1} }
      expect(response).to render_template(:edit)
    end
  end

  describe "#delete" do
    it "deletes a task " do
      allow(MultiTask).to receive(:find).with("1")
        .and_return(task)
      allow(task).to receive(:destroy).and_return(true)
      allow(task).to receive(:destroyed?).and_return(true)

      delete 'destroy', { params: { id: 1 } }
      expect(task).to be_destroyed
      expect(response).to redirect_to(:multi_task)
    end
  end
end
