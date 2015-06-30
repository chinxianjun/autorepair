class History < ActiveRecord::Base
  def self.search(search)
    if search
      where('send_man LIKE ? OR receive_man LIKE ? OR content LIKE ?',
            "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
