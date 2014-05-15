class Resume < ActiveRecord::Base
  serialize :unions

  belongs_to :user
  has_many :resume_unions
  has_many :unions, through: :resume_unions

  validates :slug, uniqueness: true

  def slug=(slug)
    slug = nil if slug.empty?
    super(slug)
  end

  private

  def slug_versions
    [
      proc { user.name },
      [proc { user.name }, :id]
    ]
  end
end
