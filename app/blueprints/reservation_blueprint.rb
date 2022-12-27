class ReservationBlueprint < Blueprinter::Base
  identifier :id

  fields :item_id, :starting_date, :ending_date, :user_id, :status, :total_value
end
