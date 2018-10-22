class MultiTask
  include Mongoid::Document
  validates_presence_of :end_date, allow_nil: true
  validates_presence_of :start_date
  validates_presence_of :description

  field :title, type: String, default: ""
  field :start_date, type: Time
  field :end_date, type: Time
  field :description, type: String
  field :finished, type: Mongoid::Boolean
  field :priority, type: Integer, default: 1
  field :frequency, type: Integer, default: 999
  field :parent, type: String, default: ""

  def subtasks
    MultiTask.where(parent: id)
  end

  def parent_task
    return nil if parent.nil?
    MultiTask.find(parent)
  end

  def formatted_start_date
    start_date.to_date.strftime("%d/%m/%Y")
  end

  def formatted_end_date
    end_date.to_date.strftime("%d/%m/%Y")
  end
end
