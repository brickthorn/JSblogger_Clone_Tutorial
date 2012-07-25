class Article < ActiveRecord::Base
  attr_accessible :title, :body, :tag_list, :image, :only

  has_many :comments
  has_many :taggings
  has_many :tags, :through => :taggings

  has_attached_file :image

  before_save :word_count

  def tag_list
    return self.tags.join(", ")
  end

  def tag_list=(tags_string)
    self.taggings.destroy_all

    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq

    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by_name(tag_name)
      tagging = self.taggings.new
      tagging.tag_id = tag.id
    end
  end

  def self.only(params)
    limit = Article.all.count if !(limit = params[:limit])
    @articles = Article.order(params[:order_by]).limit(limit)
  end

  private

  def word_count
    self.word_count = self.body.split(" ").count if body_changed?
  end

end
