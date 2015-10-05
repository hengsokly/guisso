Warden::Strategies.add(:extra_passwords_strategy, ExtraPassword::Strategy)
Warden::Manager.after_set_user do |user, auth, opts|
  auth.cookies[:guisso] = {
    value: user.email,
    expires: 1.year.from_now,
    domain: "instedd.org"
  }
end
Warden::Manager.before_logout do |user, auth, opts|
  auth.cookies[:guisso] = {
    value: "logout",
    expires: 1.year.from_now,
    domain: "instedd.org"
  }
end

Warden::Manager.before_failure do |env, opts|
  Telemetry::Auth.failed
end
