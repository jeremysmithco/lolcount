every 5.minutes do
  rake "forum:receive_mail"
  rake "thinking_sphinx:index"
end
