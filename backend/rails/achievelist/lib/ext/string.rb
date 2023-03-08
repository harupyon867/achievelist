class String
  def to_bool
    if self =~ /(true|True|TRUE)/
      true
    elsif self =~ /(false|False|FALSE)/
      false
    else
      self
    end
  end
end
