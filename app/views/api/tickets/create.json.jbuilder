if @context.success?
  json.partial! 'tickets/ticket', object: @ticket
else
  json.partial! 'shared/errors', object: @ticket
end
