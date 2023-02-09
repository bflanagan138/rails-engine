class ItemErrorSerializer

  def self.error_json(error, status)
    {
      message: "your request for #{error.id} could not be completed due to a #{status} error",
      errors: [
        { 
          title: error.message,
          status: status.to_s
        }
      ]
    }
  end

  def self.missing_item_error_json(error, status)
    {
      message: "your request could not be completed due to a #{status} error",
      errors: [
        { 
          title: error.message,
          status: status.to_s
        }
      ]
    }
  end
end