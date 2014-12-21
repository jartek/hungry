class Admin < User
  self.table_name = "users"

  private

  def set_default_role
    self.role ||= :admin
  end
end
