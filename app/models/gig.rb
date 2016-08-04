class Gig < ApplicationRecord

  scope :past, -> { where("performance_date < ?", Date.today) }
  scope :future, -> { where("performance_date >= ?", Date.today) }

end
