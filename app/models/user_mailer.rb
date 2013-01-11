class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{SITE_URL}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{SITE_URL}/"
  end
  
  def reset_notification(user)
    setup_email(user)
    @subject    += 'Link to reset your password'
    @body[:url]  = "#{SITE_URL}/reset/#{user.reset_code}"
  end

  def used_car_ad(used_car)
    setup_email(used_car.user)
    @subject    += 'Your Ad has been posted successfully'
    @body[:user] = used_car.user.name
    @body[:make] = used_car.make
    @body[:model] = used_car.model
  end

  def new_car_ad(new_car)
    admin_mail(new_car.user.email,new_car.user.name)
    @subject    += 'Your car has been posted successfully'
    @body[:user] = new_car.user.name
    @body[:make] = new_car.make
    @body[:model] = new_car.model
  end

  def vendor_creation(vendor)
    setup_email(vendor.user)
    @subject += 'Your business has been successfully registered'
    @body[:user] = vendor.user.name
    @body[:name] = vendor.name
  end

  def ask_question(questions,number,email,user_name,used_car)
    setup_email(used_car.user)
    @body[:number] = number
    @body[:questions] = questions
    @body[:email] = email
    @body[:user_name] = user_name
  end

  def contact_us(email, user_name, message)
    admin_mail(email, user_name)
    @body[:message] = message
    @body[:email] = email
  end

  def suggest(questions,number,email,user_name)
    admin_mail(email, user_name)
    @body[:number] = number
    @body[:questions] = questions
    @body[:email] = email
  end

  def suggest_merchant(merchant_name,category,phone,comments)
    admin_mail('', '')
    @body[:name] = merchant_name
    @body[:category] = category
    @body[:phone] = phone
    @body[:comments] = comments
  end

  def report_error(name,contact_no,email,error)
    admin_mail(email,name)
    @subject += 'An error report has been posted'
    @body[:contact_no] = contact_no
    @body[:error] = error
  end

  def advertise(name,phone,email,remarks,organisation)
    admin_mail(email,name)
    @subject += 'An advertisement request has been posted'
    @body[:phone] = phone
    @body[:remarks] = remarks
    @body[:organisation] = organisation
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "admin@noahhendrix.com"
      @subject     = "[#{SITE_URL}] "
      @sent_on     = Time.now
      @body[:user] = user
    end

    def admin_mail(email,user_name)
      @recipients  = "bilal.duwheels@gmail.com"
      @from        = email
      @subject     = "[#{SITE_URL}] "
      @sent_on     = Time.now
      @body[:user] = user_name
    end
end
