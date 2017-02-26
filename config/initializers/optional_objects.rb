class Object
  def maybe
    Some.new(self)
  end
end

class NilClass
  def maybe
    None.new
  end
end

class Some
  def initialize(object)
    @object = object
  end

  def get
    @object
  end

  def present?
    true
  end

  def blank?
    false
  end
end

class UnwrappedNil < StandardError; end
class None
  def get
    raise UnwrappedNil
  end

  def present?
    false
  end

  def blank?
    true
  end
end