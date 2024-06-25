class Bus < ApplicationRecord
    belongs_to :user
    enum bus_type: [:Ac , :NonAc]
end
