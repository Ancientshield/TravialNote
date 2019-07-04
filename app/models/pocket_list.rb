class PocketList < ApplicationRecord
  belongs_to :user

  def week
    date = expect_date.days_to_week_start
    case date
    when 0
      return '一'
    when 1
      return '二'
    when 2
      return '三'
    when 3
      return '四'
    when 4
      return '五'
    when 5
      return '六'
    when 6
      return '日'
    end
  end
end
