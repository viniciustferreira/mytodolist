module MultiTasksHelper

  def options(task)
    options = [ link_to('Detalhes', task, class: "dropdown-item"),
     link_to('Editar', edit_multi_task_path(task), class: "dropdown-item"),
     link_to('Excluir', task, method: :delete, data: { confirm: 'Excluir: Tem certeza?' }, class: "dropdown-item") ]

    content_tag :div, class: "dropdown " do
      button =  button_tag 'Opções', class: 'btn btn-secondary dropdown-toggle', data: { toggle: :dropdown }
      content = content_tag :div, class: "dropdown-menu" do
        options.join.html_safe
      end
      (button + content).html_safe
    end
  end
end
