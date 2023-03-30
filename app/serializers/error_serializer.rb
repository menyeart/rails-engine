class ErrorSerializer
  include JSONAPI::Serializer

  def initialize(error_object)
    @error = error_object
  end

  def serialize
    {
      error: {
        id: nil,
        attributes: []
      },
      message: @error.message
    }
  end

  def self.error_to_empty
    {
      data: {},
      message: "Object not found"
    }
  end
end