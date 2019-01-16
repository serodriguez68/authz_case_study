module ServicesHelper

  def safe_driver_name(service)
        service.driver_name || 'No driver'
  end

  def requested_on_info(service)
    service.created_at ? "Requested: #{l service.created_at, format: :short}" : nil
  end

  def cancelled_on_info(service)
    service.cancelled_on ? "Cancelled: #{l service.cancelled_on, format: :short}" : nil
  end

  def accepted_on_info(service)
    service.accepted_on ? "Accepted: #{l service.accepted_on, format: :short}" : nil
  end

  def finished_on_info(service)
    service.finished_on ? "Finished: #{l service.finished_on, format: :short}" : nil
  end



  # def cancelled_on_info(service)
end
