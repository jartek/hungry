class Admin < User
  self.table_name = "users"

  default_scope { where(role: 2) }

  private

  def set_default_role
    self.role = :admin
  end
end
