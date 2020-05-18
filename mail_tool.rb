require 'mail' 
require 'openssl'
require_relative 'html_helper'
require_relative 'summary'


=begin
attachment = $LOG_FILE 
options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'localhost',
            :user_name            => 'nxpkextester@gmail.com',
            :password             => 'Hap$1234',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }


Mail.defaults do
  delivery_method :smtp, options
end

Mail.deliver do
       to 'hake.huang@nxp.com'
     from 'nxpkextester@gmail.com'
  subject 'scan zip build #{Time.now} and manufest analysis'
     body 'scan zip build'
     add_file attachment
end


Mail.defaults do
  retriever_method :pop3, :address    => "pop.gmail.com",
                          :port       => 995,
                          :user_name  => 'nxpkextester@gmail.com',
                          :password   => 'Hap$1234',
                          :enable_ssl => true
end
emails = Mail.find(:what => :first, :count => 5)
# loop thru all emails and print content
emails.each do |email|
 
    # email fields defined at https://github.com/mikel/mail/tree/master/lib/mail/fields
    puts "from     : " + email.from.to_s       #=> 'fromname@example.com'
    puts "to       : " + email.to.to_s         #=> 'toname@example.com'
    puts "cc       : " + email.cc.to_s         #=> 'ccname@example.com'
    puts "bcc      : " + email.bcc.to_s        #=> 'bccname@example.com'    
    
    puts "subject  : " + email.subject         #=> "This is the subject"
    puts "date     : " + email.date.to_s       #=> '26 Nov 2013 10:00:00 -0800'
    puts "messageid: " + email.message_id      #=> '<ABCD1234.12345678@xxx.xxx>'
    puts "body     : " + email.body.decoded    #=> 'This is the body of the email...    
 
end

=end
#new start parser the information


attachment = $LOG_FILE 
#=begin
options = { :address              => "smtp.gmail.com",
            :port                 => 587,
           # :domain               => 'localhost',
            :user_name            => 'nxpkextester@gmail.com',
            :password             => 'rjpwmrqohsdycdyj',
           # :password             => 'Hap$1234',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }
#=end
=begin
options = { :address              => "remotesmtp.freescale.net",
            :port                 => 25,
            :domain               => 'localhost',
#           :user_name            => 'dpc@nxp.com',
#            :password             =>  'gubnnvmsjcyvtrqq', #'Hap$1234',
#            :authentication       => 'plain',
#            :enable_starttls_auto => true  
}
=end


Mail.defaults do
  delivery_method :smtp, options
end


mail_ct = summary_schools()

#puts mail_ct

#add conent parser here
#puts mail_ct

#=begin
  
Mail.deliver do
    to 'hake.huang@nxp.com'
    cc 'hake.huang@nxp.com'
    from 'nxpkextester@gmail.com'
  subject "Shanghai high school daily scan"
     body ''
     #add_file attachment

    html_part do
      content_type 'text/html; charset=UTF-8'
      body "#{mail_ct}"
  end
end
#=end
