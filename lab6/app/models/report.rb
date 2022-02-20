class Report < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :grade, numericality: { only_integer: true, greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 100, allow_nil: true }

  def format_grade
    format_grade = "(#{grade})"
    case grade.to_i
    when 95..100
      format_grade.prepend('A')
    when 86..94
      format_grade.prepend('B')
    when 69..85
      format_grade.prepend('C')
    when 61..68
      format_grade.prepend('D')
    when 51..60
      format_grade.prepend('E')
    when 31..50
      format_grade.prepend('FX')
    when 0..30
      format_grade.prepend('F')
    end
    format_grade
  end
end
