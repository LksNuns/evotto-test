class String
  #
  # Método copiado de ActiveSupport do Rails
  # https://github.com/rails/rails/blob/5-2-stable/activesupport/lib/active_support/inflector/methods.rb#L92
  #
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end
