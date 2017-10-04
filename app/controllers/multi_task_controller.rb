class MultiTaskController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = MultiTask.new
  end

  def index
    @tasks = MultiTask.all
  end

  def create
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to multi_task_path(@task) , notice: 'Tarefa foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to multi_task_url, notice: 'A tarefa foi removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = MultiTask.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:start_date, 
      :end_date, :description, :finished, :priority, :frequency, :parent)
  end
end
