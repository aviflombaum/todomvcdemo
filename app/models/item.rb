class Item < ActiveRecord::Base
  belongs_to :list

  def complete?
    status == 1
  end

  def incomplete?
    status == 0
  end
  
end
