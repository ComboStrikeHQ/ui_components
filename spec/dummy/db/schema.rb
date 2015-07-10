ActiveRecord::Schema.define do
  create_table 'foxes', force: :cascade do |t|
    t.string 'species'
  end
end
