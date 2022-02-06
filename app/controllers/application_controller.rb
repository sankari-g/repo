# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    respond_to do |format|
      format.html { render template: 'errors/record_not_found' }
    end
  end
end
