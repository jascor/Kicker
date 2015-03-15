json.media do
  json.id @media.id
  json.filename @media.filename
  json.title @media.title
  json.credit @media.credit
  json.mime_type @media.mime_type
  json.s3_key @media.s3_key
  json.link @media.link
  json.secure_link @media.secure_link
  json.caption @media.caption
  json.video @media.video
  json.pending_initial_edit @media.pending_initial_edit
  json.created_at @media.created_at
  json.updated_at @media.updated_at
end