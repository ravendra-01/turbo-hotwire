class WorkExperience < ApplicationRecord
  EMPLOYMENT_TYPE = ['Full-Time', 'Part-Time', 'Self-Employeed', 'Freelance', 'Trainee', 'Internship']
  LOCATION_TYPE = ['On-Site', 'Hybrid', 'Remote']
  belongs_to :user

  validates :company, :start_date, :job_title, :location, presence: true
  validates :location_type, presence: true, inclusion: { in: LOCATION_TYPE, message: ' not a valid location type' }
  validates :employment_type, presence: true, inclusion: { in: EMPLOYMENT_TYPE, message: ' not a valid employment type' }
  
  validate :work_experiences_end_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date, if: :currently_not_working_here?

  def company_with_employment_type
    "#{company} (#{employment_type})".strip
  end

  def job_location
    "#{location} (#{location_type})".strip
  end

  def job_duration
    months = end_date.present? ? get_months(end_date) : get_months(Date.today)
    result = months.divmod(12)
    duration = "#{result.first} #{result.first > 1 ? 'years' : 'year'} #{result.last} #{result.last > 1 ? 'months' : 'month'}"

    if currently_working_here
      "#{start_date.strftime("%b %y")} - Present (#{duration})"
    else
      "#{start_date.strftime("%b %y")} - #{end_date.strftime("%b %y")} (#{duration})"
    end
  end

  private

  def get_months(last_date)
    ((last_date.year - start_date.year) * 12 + last_date.month - start_date.month - (last_date.day >= start_date.day ? 0 : 1)).round
  end

  def work_experiences_end_date
    if end_date.present? && currently_working_here
      errors.add(:end_date, " must be blank if you are currently working in this company")
    end
  end

  def presence_of_end_date
    if end_date.nil? && !currently_working_here
      errors.add(:end_date, " must be present if you are not currently working in this company")
    end
  end

  def currently_not_working_here?
    !currently_working_here
  end

  def end_date_greater_than_start_date
    return if end_date.nil?
    errors.add(:end_date, " must be greater than start date") if end_date < start_date
  end
end
