class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  def github_deployment(payload)
    OutsideStandardSupportHours.new(
      app: payload['repository']['name'],
      environment: payload['deployment']['environment'],
      user: payload['deployment']['creator']['login'],
      deployed_at: payload['deployment']['created_at'],
    ).call
  end

  def webhook_secret(payload)
    Rails.application.secrets.github_webhook_secret
  end
end
