# The main logical service class of the repo. Enacts rules to make a deploying engineer responsible for the code they ship out of 'allowed' hours.
class OutsideStandardSupportHours
  cattr_accessor :slack

  def initialize(app:, user:, environment:, deployed_at:)
    @app = app
    @user = user
    @environment = environment
    @deployed_at = Time.parse(deployed_at).in_time_zone("Europe/London")
  end

  def call
    return if inside_standard_support_hours?

    announcement = ENV['ANNOUNCEMENT'] || "Github user *%{user}* took responsibility for _%{app}_ (at _%{environment}_) by deploying outside of standard support hours."

    slack.ping announcement % { user: @user, app: @app, environment: @environment }
  end

  private

  def inside_standard_support_hours?
    case @deployed_at.wday
    when 0, 6 # Sun, Sat
      return false
    when 1,2,3,4 # Mon-Thurs
      return @deployed_at.hour >= 9 && @deployed_at.hour < 18
    when 5 # Fri
      return @deployed_at.hour >= 9 && @deployed_at.hour < 12
    end
  end

  def slack
    @_slack ||= Slack::Notifier.new Rails.application.secrets.slack_webhook_url
  end
end
