class Photo < ActiveRecord::Base

  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "",
                    :url => ":s3_domain_url",
                    :path => "/:class/:attachment/:id/:style/:filename"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # has_attached_file :image,
  #                   :styles => { :medium => "300x300>", :thumb => "100x100>" },
  #                   :default_url => "/images/:style/missing.png",
  #                   :url => ":s3_domain_url",
  #                   :path => "/:class/:attachment/:id/:style/:filename"
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # :default_url => "/images/:style/missing.png" - causes errors in testing

  belongs_to :user

  has_many :comments,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  has_many :likes,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  validates_presence_of :descr

end
