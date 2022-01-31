class Genre < ApplicationRecord
   has_many :items, dependent: :destory
end
