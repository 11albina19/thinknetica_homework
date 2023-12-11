# frozen_string_literal: true

require_relative 'accessors'

class Test
  extend Accessors

  attr_accessor_with_history :x, :y
  strong_attr_accessor(:a, "String")
end
