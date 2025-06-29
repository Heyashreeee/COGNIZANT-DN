namespace CustomerCommLib
{
    public class CustomerComm
    {
        private readonly IMailSender _mailSender;

        /// <param name="mailSender">An instance of a class implementing IMailSender.</param>
        public CustomerComm(IMailSender mailSender)
        {
            _mailSender = mailSender;
        }

        public bool SendMailToCustomer()
        {
            string customerEmailAddress = "cust123@abc.com";
            string customerMessage = "Some Message";

            return _mailSender.SendMail(customerEmailAddress, customerMessage);
        }
    }
}