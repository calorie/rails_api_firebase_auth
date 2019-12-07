Firebase::Auth::IDTokenKeeper.configure do |config|
  config.firebase_project_id = ENV['FIREBASE_PROJECT_ID']
end
