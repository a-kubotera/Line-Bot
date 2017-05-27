class Sticker < ActiveRecord::Base
  def get_Random
    @min = Sticker.minimum(:id)
    @max = Sticker.maximum(:id)
    @random = Random.rand(@min .. @max)
  end
end
