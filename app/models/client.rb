class Client < User
  self.table_name = "users"

  default_scope { where(role: 1) }

  has_many :restaurants

  private

  def set_default_role
    self.role = :client
  end

end
