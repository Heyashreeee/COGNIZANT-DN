﻿using System;
using System.Net;
using System.Net.Mail;

namespace CustomerCommLib
{
    public class MailSender : IMailSender
    {


        public bool SendMail(string toAddress, string message)
        {
            try
            {
                MailMessage mail = new MailMessage();
                
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                
                mail.From = new MailAddress("your_email_address@gmail.com");
                mail.To.Add(toAddress);
                mail.Subject = "Test Mail";
                mail.Body = message;

                
                SmtpServer.Port = 587;
           
                SmtpServer.Credentials = new NetworkCredential("username", "password");
                SmtpServer.EnableSsl = true; 

                SmtpServer.Send(mail); 
                return true; 
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending mail: {ex.Message}");
                return false; 
            }
        } 
    }
}