class Feed < ApplicationRecord
  has_many :readers, dependent: :destroy

  after_create :create_reader

  before_validation :strip_url

  validates :url, presence: true, uniqueness: true, format: URI::regexp(%w(http https))

  def create_reader_on_url_update
    CreateReaderWorker.perform_async(id) if saved_change_to_url?
  end

  private

  def create_reader
    CreateReaderWorker.perform_async(id)
  end

  def strip_url
    self.url = url&.strip
  end
end
