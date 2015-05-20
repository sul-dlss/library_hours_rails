class NodeMapping < ActiveRecord::Base
  belongs_to :mapped, polymorphic: true
end
