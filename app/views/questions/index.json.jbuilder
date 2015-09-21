json.array!(@questions) do |question|
  json.extract! question, :id, :question, :option_1, :option_2, :option_3, :option_4
  json.url question_url(question, format: :json)
end
