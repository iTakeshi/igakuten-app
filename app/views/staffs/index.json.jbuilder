json.array!(@staffs) do |staff|
  json.extract! staff, :id, :family_name, :family_name_yomi, :given_name, :given_name_yomi, :grade, :gender, :phone, :email, :email_verificated, :provisional
  json.url staff_url(staff, format: :json)
end
