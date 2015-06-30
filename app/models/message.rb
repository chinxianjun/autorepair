class Message < ActiveRecord::Base
  #attr_accessible :content, :creator, :category
  #attr_accessor :content, :creator, :category


  def self.search(search)
    if search
      where('title LIKE ? OR creator LIKE ? OR content LIKE ?',
            "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
