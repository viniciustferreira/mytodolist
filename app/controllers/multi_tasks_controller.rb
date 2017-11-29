class MultiTasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :possible_parents, only: [:new]

  def new
    @task = MultiTask.new
  end

  def index
    @tasks = MultiTask.all
  end

  def create
    @task = MultiTask.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Tarefa criada com sucesso.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
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

  def possible_parents
    @parents = MultiTask.where(parent: "").map { |p| [p.description, p.id.to_s] } || []
  end

  def set_task
    @task = MultiTask.find(params[:id])
  end

  def task_params
    format_params_dates
    params.require(:multi_task).permit(:title, :start_date,
      :end_date, :description, :finished, :priority, :frequency, :parent)
  end

  def format_params_dates
    params[:multi_task]["start_date"] = format_start_date

    params[:multi_task]["end_date"] = format_end_date

    remove_useless_dates
  end

  def remove_useless_dates
    params[:multi_task].delete_if do |k,v|
      k =~ /[start,end]_date\([1-9]+i\)/
    end
  end

  def format_end_date
    Date.parse("#{params[:multi_task]["end_date(3i)"].to_s}/#{params[:multi_task]["end_date(2i)"].to_s}/#{params[:multi_task]["end_date(1i)"].to_s}") if params[:multi_task]["end_date(3i)"]
  end

  def format_start_date
    Date.parse("#{params[:multi_task]["start_date(3i)"].to_s}/#{params[:multi_task]["start_date(2i)"].to_s}/#{params[:multi_task]["start_date(1i)"].to_s}") if params[:multi_task]["start_date(3i)"]
  end
end
