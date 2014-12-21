class Client < User
  self.table_name = "users"

  has_many :restaurants

  private

  def set_default_role
    self.role ||= :client
  end

end
