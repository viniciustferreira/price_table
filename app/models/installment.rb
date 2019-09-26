class Installment < ApplicationRecord
  before_save :calculate_installment_value 

  def calculate_installment_value
    part_one = 1 - (1 + monthly_interest_rate)**(-number_of_installments)
    part_two = monthly_interest_rate / part_one 
    self.installment_value = (present_value * part_two).round(2)
  end
end