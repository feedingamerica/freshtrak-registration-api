# frozen_string_literal: true

# Application Record Base Class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
