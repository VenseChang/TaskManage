class Task < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags
  
  include AASM
  enum priority: {
    extremely_urgent: 1,
    urgent: 2,
    ordinary: 3
  }

  aasm column: :priority, enum: true do
    state :ordinary, initial: true
    state :extremely_urgent, :urgent

  end


  enum status: {
    pending: 1,
    handling: 2,
    finished: 3
  }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :handling
    state :finished

    event :handle do
      transitions from: :pending, to: :handling
    end

    event :finish do
      transitions from: [:pending, :handling], to: :finished
    end
  end


  def self.status_select_tag
    statuses.map{|k, v| [I18n.t(k), k]}
  end

  def self.priority_select_tag
    priorities.map{|k, v| [I18n.t(k), k]}
  end

  def end_time_format
    end_time.strftime('%Y-%m-%d %H:%M:%S')
  end
end
