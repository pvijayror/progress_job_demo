class ExportJob < ProgressJob::Base
  def perform
    require 'csv'
    update_stage('Exporting users')
    users = User.first(10000)
    update_progress_max(users.count)
    csv_string = CSV.generate do |csv|
      users.each do |user|
        csv << [user.name, user.email]
        update_progress
      end
    end
    File.open('public/system/export.csv', 'w') { |f| f.write(csv_string) }
  end
end
