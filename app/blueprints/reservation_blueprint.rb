class ReservationBlueprint < Blueprinter::Base
  identifier :id

  fields :item_name, :starting_date, :ending_date, :status, :total_value
end
