class Inspection < ApplicationRecord
  enum status: { active: 0, archived: 1 }
end
