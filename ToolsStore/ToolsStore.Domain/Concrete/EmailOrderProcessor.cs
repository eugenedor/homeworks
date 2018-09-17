using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using System.Net;

namespace ToolsStore.Domain.Concrete
{
    public class EmailOrderProcessor : IOrderProcessor
    {
        private EmailSettings emailSettings;
        public EmailOrderProcessor(EmailSettings settings)
        {
            emailSettings = settings;
        }

        public void ProcessOrder(Cart cart, ShippingDetails shippingInfo)
        {
            using (var smtpClient = new SmtpClient())
            {
                smtpClient.EnableSsl = emailSettings.UseSsl;
                smtpClient.Host = emailSettings.ServerName;
                smtpClient.Port = emailSettings.ServerPort;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(emailSettings.Username,
                emailSettings.Password);
                if (emailSettings.WriteAsFile)
                {
                    smtpClient.DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory;
                    smtpClient.PickupDirectoryLocation = emailSettings.FileLocation;
                    smtpClient.EnableSsl = false;
                }
                StringBuilder body = new StringBuilder()
                .AppendLine("Был отправлен новый заказ")
                .AppendLine("------------------------------------------------")
                .AppendLine("Предметы:");
                foreach (var line in cart.Lines)
                {
                    var subtotal = line.Product.PriceWithVat * line.Quantity;
                    body.AppendFormat("{0} x {1} ({2}, {3}). Подитог: {4}; {5}", 
                                      line.Quantity, 
                                      line.Product.Name, 
                                      line.Product.EquipmentName.ToLower(), 
                                      line.Product.CategoryName.ToLower(), 
                                      subtotal, 
                                      Environment.NewLine);
                }
                body.AppendLine("");
                body.AppendFormat("ОБЩАЯ СУММА: {0}", cart.ComputeTotalValue());
                body.AppendLine("")
                .AppendLine("------------------------------------------------")
                .AppendLine("Отправить к:")
                .AppendLine(shippingInfo.Name)
                .AppendLine(shippingInfo.Line1)
                .AppendLine(shippingInfo.Line2 ?? "")
                .AppendLine(shippingInfo.Line3 ?? "")
                .AppendLine(shippingInfo.City)
                .AppendLine(shippingInfo.State ?? "")
                .AppendLine(shippingInfo.Country)
                .AppendLine(shippingInfo.Zip)
                .AppendLine("------------------------------------------------")
                .AppendFormat("Упаковать в подарочную упаковку: {0}", shippingInfo.GiftWrap ? "да" : "нет");
                MailMessage mailMessage = new MailMessage(
                emailSettings.MailFromAddress,                    // From
                emailSettings.MailToAddress,                      // To
                "Новый заказ!",                                   // Subject
                body.ToString());                                 // Body
                if (emailSettings.WriteAsFile)
                {
                    mailMessage.BodyEncoding = Encoding.Unicode; //Encoding.ASCII;
                }
                smtpClient.Send(mailMessage);
            }
        }
    }
}
