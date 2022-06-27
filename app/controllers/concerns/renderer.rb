# frozen_string_literal: true

module Renderer
  def execute(form)
    render data(form) if form.call
  end

  def data(form)
    send("#{action_name}_response", form)
  end

  def create_response(form)
    if "#{form.model.class.name}Serializer".constantize
      {
        json: form.model,
        status: :ok,
        serializer: "#{form.model.class.name}Serializer".constantize
      }
    else
      { json: { id: form.model.id }, status: :ok }
    end
  end

  def update_response(form)
    create_response(form)
  end

  def subscribe_response(form)
    create_response(form)
  end

  def destroy_response(form)
    { json: { message: "#{form.model.class.name} deleted successfully" }, status: :ok }
  end

  def bulk_destroy_response(form)
    { json: { message: "#{form.model.class.name}s deleted successfully" }, status: :ok }
  end
end
