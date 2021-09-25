json.errors do
  json.code '422'
  json.title 'Unprocessable entities'
  if @ticket.present?
    json.detail @ticket.errors.full_messages.join(' ')
  end
end
