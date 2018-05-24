require 'rails_helper'

RSpec.describe Vacation, type: :model do

  context 'table fields' do
    it {is_expected.to have_db_column(:description)}
    it {is_expected.to have_db_column(:status)}
    it {is_expected.to have_db_column(:vacation_date)}
  end

  context 'indices' do
    it {is_expected.to have_db_index(:description)}
    it {is_expected.to have_db_index(:status)}
    it {is_expected.to have_db_index(:vacation_date)}
  end


  context 'validations' do
    it {is_expected.to validate_presence_of(:description)}
    it {is_expected.to validate_presence_of(:status)}
    it {is_expected.to validate_presence_of(:vacation_date)}
  end

end