class Service < ApplicationRecord
  include ScopableByClient
  include ScopableByCity
  include ScopableByDriver

  PINGING_DRIVER = 'PINGING DRIVER'
  ONGOING = 'ONGOING'
  FINISHED = 'FINISHED'
  CLIENT_CANCELLED = 'CLIENT CANCELLED'

  belongs_to :client
  belongs_to :city
  belongs_to :driver, optional: true

  validates :pickup_address, presence: true
  validates :drop_off_address, presence: true

  delegate :name, to: :city, prefix: true
  delegate :name, to: :client, prefix: true
  delegate :name, to: :driver, prefix: true, allow_nil: true

  def status
    if accepted_on.blank? && finished_on.blank? && cancelled_on.blank?
      PINGING_DRIVER
    elsif accepted_on.present? && finished_on.blank?
      ONGOING
    elsif accepted_on.present? && finished_on.present?
      FINISHED
    elsif accepted_on.blank? && finished_on.blank? && cancelled_on.present?
      CLIENT_CANCELLED
    else
      raise 'something is wrong with the state machine'
    end
  end

  def can_cancel?
    status == PINGING_DRIVER
  end

  def can_accept?
    status == PINGING_DRIVER
  end

  def can_reject?
    status == PINGING_DRIVER
  end

  def can_finish?
    status == ONGOING
  end

  def assign_driver!
    driver = Driver.available.first
    update!(driver: driver)
  end

  def cancel
    if can_cancel?
      update(driver_id: nil, cancelled_on: Time.now)
    else
      false
    end
  end

  def accept
    if can_accept?
      update(accepted_on: Time.now)
    else
      false
    end
  end

  def reject
    if can_reject?
      new_driver = Driver.available.where.not(id: driver_id).first
      update(driver: new_driver, cancelled_on: nil, accepted_on: nil, finished_on: nil)
    else
      false
    end
  end

  def finish
    if can_finish?
      update(finished_on: Time.now)
    else
      false
    end
  end

end
