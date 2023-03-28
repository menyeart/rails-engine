class ErrorSerializer
  include JSONAPI::Serializer

  def initialize(error_object)
    @error = error_object
  end

  def serialize
    {
      data: {
        id: nil,
        attributes: []
      },
      message: "your query could not be completed"
    }
  end
end