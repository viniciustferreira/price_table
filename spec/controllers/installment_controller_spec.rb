require 'rails_helper.rb'

RSpec.describe InstallmentController do
  let(:create_params) { { present_value: 1000.00, number_of_installments: 4, monthly_interest_rate: 0.03 } }

  context "create" do
    it "creates a installment" do
      post :create, params: create_params
      id = Installment.last.id

      expect(JSON.parse(response.body)).to eq({ "installment_value" => 269.03, "id" => id })
    end
  end

  context "show" do
    it "show by id" do
      Installment.create(create_params.merge(id: "B62C624E-A805-11E5-8C4A-50E44124FF49"))
      get :show, params: { id: Installment.last.id }

      expect(JSON.parse(response.body)).to eq({ "installment_value" => 269.03, "id" => "B62C624E-A805-11E5-8C4A-50E44124FF49", "present_value" => 1000.00, "number_of_installments" => 4, "monthly_interest_rate" => 0.03})
    end
  end

  context "delete" do
    it "delete by id" do
      Installment.create(create_params.merge(id: "B62C624E-A805-11E5-8C4A-50E44124FF49"))
      id = Installment.last.id
      delete :destroy, params: { id: id }

      expect(response.body).to eq('')
      expect(Installment.where(id: id)).to eq([])
    end

    it "show deleted installment" do
      Installment.create(create_params.merge(id: "B62C624E-A805-11E5-8C4A-50E44124FF49"))
      id = Installment.last.id
      delete :destroy, params: { id: id }
      get :show, params: { id: id }

      expect(response.body).to eq("null")
    end
  end
end