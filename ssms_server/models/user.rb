class User Sequel::Model
  primary_key :id, Serial
  property    :user_name, String, required: true
  property    :phone_number, String
  property    :public_key, Text
end
