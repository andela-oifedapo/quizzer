json.array!(@players) do |player|
  json.extract! player, :id, :quiz_id, :user_id, :score, :progress
  json.url player_url(player, format: :json)
end
