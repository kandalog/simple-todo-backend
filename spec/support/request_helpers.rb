module RequestHelpers
  def body
    JSON.parse(response.body).deep_symbolize_keys
  end
end
