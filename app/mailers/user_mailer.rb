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

  def self.comment_mentions(comment)
    child = Child.find_by_id(comment.child_id)
    addresses = []
    comment.mentions.each do |mention|
      u = User.find_by_id(mention)
      addresses << u.email
    end
    
    subject = child.first_name.capitalize + child.last_name.capitalize
    addresses.each do |address|
      send_comment_mentions(address, subject, comment).deliver_later
    end
  end
  
  def send_comment_mentions(email, subject, comment)
    @comment = comment
    mail(to: email, subject: subject)
  end
end
