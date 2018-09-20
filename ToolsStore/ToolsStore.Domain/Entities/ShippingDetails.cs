using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace ToolsStore.Domain.Entities
{
    public class ShippingDetails
    {
        
        [Required(ErrorMessage = "Введите фамилию")]
        public string Surname { get; set; }
        [Required(ErrorMessage = "Введите имя")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Введите номер телефона")]
        public string Phone { get; set; }
        public string Email { get; set; }
        [Required(ErrorMessage = "Введите первую адресную строку")]
        public string Line1 { get; set; }
        public string Line2 { get; set; }
        public string Line3 { get; set; }
        [Required(ErrorMessage = "Введите название города")]
        public string City { get; set; }
        [Required(ErrorMessage = "Введите название штата/области")]
        public string State { get; set; }
        public string Zip { get; set; }
        [Required(ErrorMessage = "Введите название страны")]
        public string Country { get; set; }
        public bool GiftWrap { get; set; }
    }
}
