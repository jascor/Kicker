json.media do
  json.array! @media do |m|
    json.id m.id
    json.filename m.filename
    json.title m.title
    json.credit m.credit
    json.mime_type m.mime_type
    json.s3_key m.s3_key
    json.link m.link
    json.secure_link m.secure_link
    json.caption m.caption
    json.video m.video
    json.pending_initial_edit m.pending_initial_edit
    json.created_at m.created_at
    json.updated_at m.updated_at
  end
end