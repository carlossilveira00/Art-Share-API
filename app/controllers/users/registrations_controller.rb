# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: {
          code: 200,
          message: 'Signed up successfully',
          data: resource
        }
      }
    else
      render json: {
        status: {
          message: 'User could not be created succefully.',
          errors: resource.erros.full_messages
        },
        code: :unprocessable_entity
      }
    end
  end
end
