require 'capybara/rspec'

module Common

  def select_date(field_name, date)
    select "#{date.year}",  from: "#{field_name}_1i"
    select date.strftime("%B"), from: "#{field_name}_2i"
    select date.day,   from: "#{field_name}_3i"
  end
end
