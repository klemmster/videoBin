# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :video do |video|
  video.name  "Video Name"
  video.description "Video Description"
  video.origfile_file_name "Fake Attachment name"
end
