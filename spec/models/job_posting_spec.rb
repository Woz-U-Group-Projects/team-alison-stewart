require 'rails_helper'

RSpec.describe JobPosting, type: :model do
  before do
    @job_posting = FactoryGirl.create(:job_posting)
  end

  subject{ @job_posting }

  # Associations
  it { is_expected.to belong_to(:job_type) }

  # Validations
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:title)}

  # Scopes
  describe 'job_type' do
    it 'should return the job postings for the job type' do
      expect(JobPosting.job_type(@job_posting.job_type).map(&:id)).to eq([@job_posting.id])
    end
  end

  # Class methods
  describe '#self.has_active_postings?' do
    before(:each) do
      @job_posting.expiry_date = 1.week.ago
      @job_posting.save
      @job_posting2 = FactoryGirl.create(:job_posting, expiry_date: 1.week.from_now)
      @job_posting3 = FactoryGirl.create(:job_posting, expiry_date: nil)
    end

    it 'should return true if there are any job postings with an expiry date greater than today' do
      @job_posting3.expiry_date = 1.week.ago
      @job_posting3.save

      expect(JobPosting.has_active_postings?).to eq(true)
    end

    it 'should return true if there are any job postings with an expiry date of nil' do
      @job_posting2.expiry_date = 1.week.ago

      @job_posting2.save

      expect(JobPosting.has_active_postings?).to eq(true)
    end

    it 'should return false if there are no jobs with an expiry date greater than today or nil' do
      @job_posting2.expiry_date = 1.week.ago
      @job_posting2.save
      @job_posting3.expiry_date = 1.week.ago
      @job_posting3.save

      expect(JobPosting.has_active_postings?).to eq(false)
    end
  end

  describe "#self.hast_active_postings_for_job_type?" do
    before(:each) do
      @job_posting.expiry_date = 1.week.from_now
      @job_posting.job_type_id = 1
      @job_posting.save
      @job_posting2 = FactoryGirl.create(:job_posting, expiry_date: nil, job_type_id: 2)
      @job_posting3 = FactoryGirl.create(:job_posting, expiry_date: 1.week.ago, job_type_id: 3)
    end

    it 'should return true if there is a job posting with an expiry date greater than today for a given job type' do
      @job_postings = JobPosting.where(job_type_id: 1)

      expect(JobPosting.has_active_postings_for_job_type?(@job_postings, 1)).to eq(true)
    end

    it 'should return true if there is a job posting with an expiry date of nil for a given job type' do
      @job_postings = JobPosting.where(job_type_id: 2)

      expect(JobPosting.has_active_postings_for_job_type?(@job_postings, 2)).to eq(true)
    end

    it 'should return false if there is a job posting with an expiry date less than today for a given job type' do
      @job_postings = JobPosting.where(job_type_id: 3)

      expect(JobPosting.has_active_postings_for_job_type?(@job_postings, 3)).to eq(false)
    end
  end

  # Instance methods
  describe 'is_expired?' do
    it 'should return true if the job posting expiry date is before today' do
      @job_posting.expiry_date = 1.week.ago
      @job_posting.save

      expect(@job_posting.is_expired?).to eq(true)
    end

    it 'should return false if the job posting expiry date is after today' do
      @job_posting.expiry_date = 1.week.from_now
      @job_posting.save

      expect(@job_posting.is_expired?).to eq(false)
    end
  end
end
