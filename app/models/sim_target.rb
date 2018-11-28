class SimTarget < ApplicationRecord
  
  validates :year, :target, presence: true
  validates :year, uniqueness: true
  validates :year, numericality: { only_integer: true }
  validate :target, if: :check_target_length?
  # validates :sim_no, length: {is: 19}

  private

  def check_target_length?
    errors.add(:target, "is blank for some months") unless( target.split(',').size == 12)
  end
end
