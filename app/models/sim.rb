class Sim < ApplicationRecord
  validates :sim_no, :sim_type, :sim_pairedness, presence: true
  validates :sim_no, uniqueness: true
  validates :sim_no, numericality: { only_integer: true }
  validates :sim_category, presence: true, if: :check_type_and_pairedness?
  validates :sim_no, length: {is: 19}

  private

  def check_type_and_pairedness?
    ((sim_type == 'Prepaid' && sim_pairedness == 'Unpaired') || sim_type == 'Postpaid' )
  end
end
