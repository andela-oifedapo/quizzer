json.array!(@questions) do |question|
  json.extract! question, :id, :quiz_id, :question_number, :question, :option_a, :option_b, :option_c, :option_d, :answer
  json.url question_url(question, format: :json)
end
