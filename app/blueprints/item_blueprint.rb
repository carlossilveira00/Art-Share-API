class ItemBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description, :user_id, :category, :location, :current_situation
end
