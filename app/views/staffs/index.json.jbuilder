json.array!(@staffs) do |staff|
  json.extract! staff, :id, :family_name, :given_name, :phone, :email, :grade, :gender, :provisional
  json.url staff_url(staff, format: :json)
end
