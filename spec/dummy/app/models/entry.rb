class Entry < ActiveRecord::Base
  validates :slim,
    slim: {
      allow_blank: true
    }

  validates :slim_no_options,
    slim: {
      to: :html,
      allow_blank: true
    }

  validates :slim_proc,
    slim: {
      options: {pretty: false},
      to: ->(record, result) {
        record.html = result
      },
      allow_blank: true
    }

  validates :slim_attribute,
    slim: {
      options: {pretty: false},
      to: :html,
      allow_blank: true
    }

  validates :slim_scope,
    slim: {
      options: {pretty: false},
      to: :html,
      scope: :record,
      allow_blank: true
    }

  def initialize(*)
    super
    @local_value = 'local value'
  end
end
