class Task < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags
  
  validates :title, presence: true
  validates :content, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :end_time, presence: true
   
  include AASM
  enum priority: {
    extremely_urgent: 1,
    urgent: 2,
    ordinary: 3
  }

  aasm column: :priority, enum: true do
    state :ordinary, initial: true
    state :extremely_urgent
    state :urgent

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


  def self.status_select_tag_for_ransack
    statuses.map{|k, v| [I18n.t(k, scope: [:task, :select_tag]), v]}
  end

  def self.priority_select_tag_for_ransack
    priorities.map{|k, v| [I18n.t(k, scope: [:task, :select_tag]), v]}
  end

  def self.status_select_tag
    statuses.map{|k, v| [I18n.t(k, scope: [:task, :select_tag]), k]}
  end

  def self.priority_select_tag
    priorities.map{|k, v| [I18n.t(k, scope: [:task, :select_tag]), k]}
  end
end
