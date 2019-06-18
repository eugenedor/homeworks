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
        private EFDbContext context = new EFDbContext();

        private EmailSettings emailSettings;
        public EmailOrderProcessor(EmailSettings settings)
        {
            emailSettings = settings;
        }

        public void ProcessOrder(CART cart, SHIPPING_DETAILS shippingInfo)
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
                .AppendLine(shippingInfo.Surname)
                .AppendLine(shippingInfo.Name)
                .AppendLine("Мобильный телефон:")
                .AppendLine(shippingInfo.Phone)
                .AppendLine("Электронная почта:")
                .AppendLine(shippingInfo.Email)
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

        public void SaveOrder(CART cart, SHIPPING_DETAILS shippingInfo)
        {
            RS_ORDER ordr = new RS_ORDER();
            ordr.Surname = shippingInfo.Surname;
            ordr.Name = shippingInfo.Name;
            ordr.Phone = shippingInfo.Phone;
            ordr.Email = shippingInfo.Email;
            ordr.Line1 = shippingInfo.Line1;
            ordr.Line2 = shippingInfo.Line2;
            ordr.Line3 = shippingInfo.Line3;
            ordr.City = shippingInfo.City;
            ordr.State = shippingInfo.State;
            ordr.Zip = shippingInfo.Zip;
            ordr.Country = shippingInfo.Country;
            ordr.GiftWrap = shippingInfo.GiftWrap;
            ordr.DateOrder = DateTime.Now;

            context.RS_ORDER.Add(ordr);
            context.SaveChanges();

            long orderId = ordr.OrderId;

            if (orderId > 0)
            {
                foreach (CART_LINE crtLine in cart.Lines)
                {
                    RS_CART crt = new RS_CART();
                    crt.OrderId = orderId;
                    crt.ProductId = crtLine.Product.ProductId;
                    crt.PriceId = crtLine.Product.PriceId;
                    crt.Quantity = crtLine.Quantity;
                    context.RS_CART.Add(crt);
                }
                context.SaveChanges();
            }
        }
    }
}
