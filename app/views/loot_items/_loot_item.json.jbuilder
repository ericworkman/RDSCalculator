json.extract! loot_item, :id, :name, :probability, :loot_table_id, :created_at, :updated_at
json.url loot_item_url(loot_item, format: :json)
