class Item < ActiveRecord::Base
  paginates_per 10
  mount_uploader :picture, PictureUploader


  belongs_to :list, :counter_cache => true

  has_many :good_items, -> { order(position: :asc) }, dependent: :destroy
  has_many :goods, through: :good_items

  has_many :parents, class_name: 'ItemParent', :dependent => :destroy
  has_many :children, class_name: 'ItemChild', :dependent => :destroy

  # enum
  # node_top => 根节点（无父节点）
  # node_mid => 中间节点（既有父节点，亦有子节点）
  # node_bottom => 底节点（无子节点）
  enum node_type: [:node_top, :node_mid, :node_bottom]


  scope :node_tops, -> { where(node_type: node_types[:node_top]) }



end
