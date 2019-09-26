class CreateInstallment < ActiveRecord::Migration[5.2]
  def change
    create_table :installments, id: :uuid do |t|
      t.integer :number_of_installments
      t.integer :present_value 
      t.float :monthly_interest_rate
      t.float :installment_value
    end
  end
end
