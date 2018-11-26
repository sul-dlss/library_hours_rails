# frozen_string_literal: true

class NodeMapping < ApplicationRecord
  belongs_to :mapped, polymorphic: true
end
