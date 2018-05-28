class Vacation < ActiveRecord::Base
  validates_presence_of :description, :status, :vacation_date


  def self.set_default_values

    Vacation.create(description: 'Vancouver', status: 1, vacation_date: '27-05-208')
    Vacation.create(description: 'Montreal', status: 1, vacation_date: '29-05-208')
    Vacation.create(description: 'African Lion Safari', status: 1, vacation_date: '01-06-208')
    Vacation.create(description: 'Niagara', status: 1, vacation_date: '02-06-208')
    Vacation.create(description: 'Chicago', status: 1, vacation_date: '09-06-208')

    Vacation.create(description: 'Toronto', status: 2, vacation_date: '25-05-208')
    Vacation.create(description: 'Milton', status: 2, vacation_date: '26-05-208')


    Vacation.create(description: 'Seattle', status: 3, vacation_date: '23-05-208')
    Vacation.create(description: 'New York', status: 3, vacation_date: '24-05-208')
  end
end
