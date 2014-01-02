json.array!(@staffs) do |staff|
  json.extract! staff, :id, :full_name, :full_name_yomi, :grade, :gender_to_s, :phone, :email, :email_verificated, :provisional
end
