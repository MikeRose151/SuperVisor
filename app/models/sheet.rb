class Sheet < ApplicationRecord
  has_many :inspections

  def name_with_url
    "#{name} (#{google_file_id[0..7]}...)"
  end
end
