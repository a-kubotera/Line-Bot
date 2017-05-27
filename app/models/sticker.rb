class Sticker < ActiveRecord::Base
  def self.get_random
    min = Sticker.minimum(:id)
    max = Sticker.maximum(:id)
    random = Random.rand(min .. max)
    self.find(random)
  end
end
