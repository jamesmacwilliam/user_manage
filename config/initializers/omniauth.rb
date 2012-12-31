Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET, display: 'popup'
end
