# frozen_string_literal: true

class Float
  def trim
    i = to_i
    f = to_f
    i == f ? i : f.round(1)
  end
end
