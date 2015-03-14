class ApplicationBuilder
  attr_reader :object, :params

  def initialize(object, params)
    @object = object
    @params = params
  end

  def save!
    object.save
  end

end
