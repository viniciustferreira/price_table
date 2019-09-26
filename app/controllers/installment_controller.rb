class InstallmentController < ApplicationController

  def create
    @installment = Installment.create(create_params.merge(id: SecureRandom.uuid))
    render json: { installment_value: @installment.installment_value, id: @installment.id }
  end

  def show
    @installment = Installment.find_by(show_params)
    render json: @installment
  end

  def destroy
    @installment = Installment.find_by(show_params)
    @installment.destroy
  end

  private

  def create_params
    params.permit(:present_value, :number_of_installments, :monthly_interest_rate)
  end

  def show_params
    params.permit(:id)
  end
end