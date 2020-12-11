class UserMailer < ApplicationMailer
  default from: 'andrewfamilyfinding@weblightdevelopment.com'

  def comment_reply(comment)
    @comment = comment
    comment_replied_to = Comment.find_by_id(comment.in_reply_to)
    @user_replied_to = comment_replied_to.user
    child = Child.find_by_id(comment.child_id)
    
    address = @user_replied_to.email
    subject = child.first_name.capitalize + child.last_name.capitalize
    mail(to: address, subject: subject)
  end
end
