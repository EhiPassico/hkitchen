class Vacation < ActiveRecord::Base
  validates_presence_of :description, :status, :vacation_date


  def self.set_default_values(user_id)

    Vacation.create(description: 'Vancouver', status: 1, vacation_date: '2018-05-27', user_id: user_id)
    Vacation.create(description: 'Montreal', status: 1, vacation_date: '2018-05-29', user_id: user_id)
    Vacation.create(description: 'African Lion Safari', status: 1, vacation_date: '2018-06-01', user_id: user_id)
    Vacation.create(description: 'Niagara', status: 1, vacation_date: '2018-06-02', user_id: user_id)
    Vacation.create(description: 'Chicago', status: 1, vacation_date: '2018-06-09', user_id: user_id)

    Vacation.create(description: 'Toronto', status: 2, vacation_date: '2018-05-25', user_id: user_id)
    Vacation.create(description: 'Milton', status: 2, vacation_date: '2018-05-26', user_id: user_id)


    Vacation.create(description: 'Seattle', status: 3, vacation_date: '2018-05-23', user_id: user_id)
    Vacation.create(description: 'New York', status: 3, vacation_date: '2018-05-24', user_id: user_id)
  end
end
