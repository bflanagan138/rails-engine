class MerchantErrorSerializer 
  def self.error_json(error, status)
    {
      message: "your request for merchant #{error.id} could not be completed due to a #{status} error",
      errors: [
        { 
          title: error.message,
          status: status.to_s
        }
      ]
    }
  end

  def self.search_error(status)
    {
      message: "your request for merchant could not be completed due to a #{status} error", 
      errors: [
        {
          title: "Search Again",
          status: status.to_s
        }
      ]
    }
  end
end