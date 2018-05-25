require 'rails_helper'

RSpec.describe VacationsController do

  describe 'GET index' do
    it 'renders index page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST create' do
    context 'valid data' do
      let(:vacation) {{description: "Toronto", vacation_date: '27-05-2018', status: 1}}
      it 'saves the record in the database' do
        post :create, vacation: vacation
        expect(Vacation.last.description).to eq("Toronto")
      end

      it 'saves the record and the vacation table is increased by 1' do
        expect {post :create, vacation: vacation}.to change(Vacation, :count).by(1)
      end

      it 'renders json with status success' do
        post :create, vacation: vacation
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["status"]).to eq('success')
      end
    end

    context 'invalid data' do
      let(:invalid_vacation) {{vacation_date: '27-05-2018', status: 1}}

      it 'does not save the record in the database' do
        expect {post :create, vacation: invalid_vacation}.to change(Vacation, :count).by(0)
      end
      it 'renders json with status fail' do
        post :create, vacation: invalid_vacation
        expect(JSON.parse(response.body)["status"]).to eq("fail")
      end
    end
  end


  describe 'POST update_status' do
    let(:vacation) {Vacation.create(description: "Toronto", vacation_date: '26-05-2018', status: 1)}
    context 'vacation exists' do
      context 'existing status is same as requested status update' do
        it 'renders json with status fail' do
          post :update_status, vacation_id: vacation.id, status: 1
          expect(JSON.parse(response.body)["status"]).to eq('fail')
        end
      end
      context 'existing status is different as requested status update' do
        it 'renders json with status success' do
          post :update_status, vacation_id: vacation.id, status: 2
          expect(JSON.parse(response.body)["status"]).to eq('success')
        end
      end
    end
    context 'vacation not exists' do
      it 'renders json with status fail' do
        post :update_status, vacation_id: 3, status: 2
        expect(JSON.parse(response.body)["status"]).to eq('fail')
      end
    end
  end

  describe 'POST update' do

    context 'vacation exists' do
      # let(:vacation) {Vacation.create(description: "Toronto", vacation_date: '26-05-2018', status: 1)}
      let!(:vacation) {FactoryBot.create(:vacation, description: "Toronto", vacation_date: '26-05-2018', status: 1)}
      let(:updated_vacation) {FactoryBot.attributes_for(:vacation, description: "vancouver", id: vacation.id)}
      it 'updates the record in the database' do
        post :update, vacation: updated_vacation
        vacation.reload
        expect(vacation.description).to eq("vancouver")
      end
      it 'render json status success' do
        post :update, vacation: updated_vacation
        expect(JSON.parse(response.body)["status"]).to eq('success')
      end
    end
    context 'vacation does not exist' do
      let!(:vacation) {FactoryBot.create(:vacation, description: "Toronto", vacation_date: '26-05-2018', status: 1)}
      let(:invalid_vacation) {FactoryBot.attributes_for(:vacation, id: 33)}
      it 'renders json status fail' do
        post :update, vacation: invalid_vacation
        expect(JSON.parse(response.body)["status"]).to eq('fail')
      end
    end
  end

  describe 'GET reset' do
    let!(:vacation1) {FactoryBot.create(:vacation, description: "Toronto1", vacation_date: '26-05-2018', status: 1)}
    let!(:vacation2) {FactoryBot.create(:vacation, description: "Toronto2", vacation_date: '26-05-2018', status: 1)}
    let!(:vacation3) {FactoryBot.create(:vacation, description: "Toronto3", vacation_date: '26-05-2018', status: 1)}

    it 'clears all the records in the vacation table' do
      get 'reset'
      expect(Vacation.count).to eq(0)
    end

  end


  describe 'GET get_vacations_for_status' do
    let!(:vacation1) {FactoryBot.create(:vacation, description: "Toronto1", vacation_date: '26-05-2018', status: 1)}
    let!(:vacation2) {FactoryBot.create(:vacation, description: "Toronto2", vacation_date: '26-05-2018', status: 1)}
    let!(:vacation3) {FactoryBot.create(:vacation, description: "Toronto3", vacation_date: '26-05-2018', status: 2)}
    let!(:vacation4) {FactoryBot.create(:vacation, description: "Toronto4", vacation_date: '26-05-2018', status: 2)}
    let!(:vacation5) {FactoryBot.create(:vacation, description: "Toronto4", vacation_date: '26-05-2018', status: 3)}

    it 'gets the planned vacations when status is 1' do
      get :get_vacations_for_status, status: 1
      expect(assigns(:vacations).count).to eq(2)
    end

    it 'gets the completed vacations when status is 2' do
      get :get_vacations_for_status, status: 2
      expect(assigns(:vacations).count).to eq(2)
    end


    it 'gets the cancelled vacations when status is 3' do
      get :get_vacations_for_status, status: 3
      expect(assigns(:vacations).count).to eq(1)
    end


  end
end