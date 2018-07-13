class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time_format(time)
    time.strftime('%Y-%m-%d %H:%M:%S')
  end
end
