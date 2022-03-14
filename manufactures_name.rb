module ManufacturesName
  attr_reader :manufactures_name
  
  def set_name(name)
    self.manufactures_name = name
  end

  protected
  attr_writer :manufactures_name
end
