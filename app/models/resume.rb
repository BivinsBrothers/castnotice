class Resume < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug_versions, use: :slugged

  serialize :unions

  belongs_to :user
  has_many :resume_unions
  has_many :unions, through: :resume_unions

  validates :slug, uniqueness: true

  def slug=(slug)
    if slug.empty?
      slug = nil
    else
      slug = slug.parameterize
    end

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
