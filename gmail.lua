-- Modifications for GMAIL by Andreas "Andy" Reischle: www.AReResearch.net  
 -- See https://support.google.com/a/answer/176600?hl=de for details on smtp with gmail  
 -- Now that NodeMCU has working SSL support, we can also talk to email services that  
 -- require encryption.   
 -- Caveat: I have not looked into the SSL implementation, but I suspect it is vulnerable  
 -- to man-in-the-middle attacks as the client doesn't check the server's certificate.  
 -- 20160415 ARe  
 --------Original Credits:  
 --------  
 ------- Working Example: https://www.youtube.com/watch?v=CcRbFIJ8aeU  
 ------- @description a basic SMTP email example. You must use an account which can provide unencrypted authenticated access.  
 ------- This example was tested with an AOL and Time Warner email accounts. GMail does not offer unecrypted authenticated access.  
 ------- To obtain your email's SMTP server and port simply Google it e.g. [my email domain] SMTP settings  
 ------- For example for timewarner you'll get to this page http://www.timewarnercable.com/en/support/faqs/faqs-internet/e-mailacco/incoming-outgoing-server-addresses.html  
 ------- To Learn more about SMTP email visit:  
 ------- SMTP Commands Reference - http://www.samlogic.net/articles/smtp-commands-reference.htm  
 ------- See "SMTP transport example" in this page http://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol  
 ------- @author Miguel  
 --no longer required because it is part of the crypto module: require("base64")  
 -- The email and password from the account you want to send emails from  
 local MY_EMAIL = GlobalConfig.EmailAddress 
 local EMAIL_PASSWORD = GlobalConfig.EmailPassword  
 -- The SMTP server and port of your email provider.  
 -- If you don't know it google [my email provider] SMTP settings  
 local SMTP_SERVER = GlobalConfig.SmtpServer
 local SMTP_PORT = GlobalConfig.SmtpPort
 -- The account you want to send email to  
 local mail_to = "ns@geotechnic.co.uk"  
 -- These are global variables. Don't change their values  
 -- they will be changed in the functions below  
 local email_subject = ""  
 local email_body = ""  
 local count = 0  
 local smtp_socket = nil -- will be used as socket to email server  
 -- The received() function will be used to print the SMTP server's response and trigger the do_next() function
 local retry = 3
 function received(sck,response)  
    print("Got a response: ")  
    print(response)
    local CompletionCode = response:sub(1,3) + 0
    if CompletionCode < 400 then
        do_next()
    else
        if retry > 0 then
            print(smtp_socket:getpeer())
            if smtp_socket:getpeer() then
                smtp_socket:send("QUIT\r\n")
                smtp_socket:close()
            end
            retry = retry - 1
            send_email(email_subject,email_body)  

        else
            print("Unable To Send Email")
        end
    end
 end  
 -- The do_next() function is used to send the SMTP commands to the SMTP server in the required sequence.  
 -- I was going to use socket callbacks but the code would not run callbacks after the first 3.  
 function do_next()  
       if(count == 0)then  
         count = count+1  
         local IP_ADDRESS = wifi.sta.getip()  
         print ("Send my IP: " .. IP_ADDRESS)  
         smtp_socket:send("HELO "..IP_ADDRESS.."\r\n")  
       elseif(count==1) then  
         count = count+1  
         smtp_socket:send("AUTH LOGIN\r\n")  
       elseif(count == 2) then  
         count = count + 1  
         smtp_socket:send(crypto.toBase64(MY_EMAIL).."\r\n")  
       elseif(count == 3) then  
         count = count + 1  
         smtp_socket:send(crypto.toBase64(EMAIL_PASSWORD).."\r\n")  
       elseif(count==4) then  
         count = count+1  
         smtp_socket:send("MAIL FROM:<" .. MY_EMAIL .. ">\r\n")  
       elseif(count==5) then  
         count = count+1
         for recipient in string.gmatch(mail_to,"([^,]+)") do
            smtp_socket:send("RCPT TO:<" .. recipient ..">\r\n")
         end  
       elseif(count==6) then  
         count = count+1  
         smtp_socket:send("DATA\r\n")  
       elseif(count==7) then  
         count = count+1  
         local message = string.gsub(  
         "From: \"".. MY_EMAIL .."\"<"..MY_EMAIL..">\r\n" ..  
         "To: \"".. mail_to .. "\"<".. mail_to..">\r\n"..  
         "Subject: ".. email_subject .. "\r\n\r\n" ..  
         email_body,"\r\n.\r\n","")  
         smtp_socket:send(message.."\r\n.\r\n")  
       elseif(count==8) then  
         count = count+1  
          smtp_socket:send("QUIT\r\n")  
       else
         print("Closing socket")
         smtp_socket:close()
         smtp_socket = nil
         print("Socket Closed")
       end  
 end  
 -- The connected() function is executed when the SMTP socket is connected to the SMTP server.  
 -- This function will start the email process and then it will get picked up by the received() function
 function connected(sck)  
   print("Connected")  
   do_next()
 end  
 -- @name send_email  
 -- @description Will initiated a socket connection to the SMTP server and trigger the connected() function  
 -- @param subject The email's subject  
 -- @param body The email's body  
 function send_email(subject,body,mailto)  
    count = 0  
    email_subject = subject  
    email_body = body
    mail_to = mailto
    print ("Open Connection")  
    smtp_socket = net.createConnection(net.TCP,1)  
    smtp_socket:on("connection",connected)  
    smtp_socket:on("receive",received)  
    smtp_socket:connect(SMTP_PORT,SMTP_SERVER)  
 end   
  
