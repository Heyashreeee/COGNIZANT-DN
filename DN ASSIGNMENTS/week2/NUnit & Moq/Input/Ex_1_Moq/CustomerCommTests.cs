using NUnit.Framework; 
using Moq;           
using CustomerCommLib; 

namespace CustomerCommLib.Tests
{

    [TestFixture]
    public class CustomerCommTests
    {

        [Test]
        public void SendMailToCustomer_ShouldCallMailSenderAndReturnTrue()
        {

            var mockMailSender = new Mock<IMailSender>();

            mockMailSender.Setup(m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                          .Returns(true);

            var customerComm = new CustomerComm(mockMailSender.Object);

            bool result = customerComm.SendMailToCustomer();


            Assert.That(result, Is.True, "SendMailToCustomer should return true on successful mail send.");

            mockMailSender.Verify(m => m.SendMail("cust123@abc.com", "Some Message"), Times.Once());
        }

        [Test]
        public void SendMailToCustomer_ShouldReturnFalse_WhenMailSenderFails()
        {
            var mockMailSender = new Mock<IMailSender>();

            mockMailSender.Setup(m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                          .Returns(false);

            var customerComm = new CustomerComm(mockMailSender.Object);

            bool result = customerComm.SendMailToCustomer();

            Assert.That(result, Is.False, "SendMailToCustomer should return false when mail sender fails.");

            mockMailSender.Verify(m => m.SendMail("cust123@abc.com", "Some Message"), Times.Once());
        }
    }
}
