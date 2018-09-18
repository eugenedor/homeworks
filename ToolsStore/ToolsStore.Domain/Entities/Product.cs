using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToolsStore.Domain.Entities
{
    public class Product
    {
        public long ProductId { get; set; }

        public long EquipmentId { get; set; }

        public long? CategoryId { get; set; }

        public long BrandId { get; set; }

        public long ModelId { get; set; }

        public long? ImageId { get; set; }

        public string Name { get; set; }

        public string Descr { get; set; }

        public decimal? Mass { get; set; }

        public decimal? Length { get; set; }

        public decimal? Width { get; set; }

        public decimal? Height { get; set; }

        public string Color { get; set; }

        public long? Power { get; set; }

        public string Kit { get; set; }

        public string EquipmentName { get; set; }

        public string EquipmentNameExtra { get; set; }

        public int? EquipmentOrd { get; set; }

        public string CategoryName { get; set; }

        public int? CategoryOrd { get; set; }

        public string BrandName { get; set; }

        public string ModelName { get; set; }

        public byte[] Data { get; set; }

        public string MimeType { get; set; }

        public string ImageName { get; set; }

        public long? PriceId { get; set; }

        public decimal? PriceWithVat { get; set; }

        public decimal? PriceWithoutVat { get; set; }

        public DateTime? DateBegin { get; set; }

        public DateTime? DateEnd { get; set; }

        public long? Vat { get; set; }

        public string VatName { get; set; }

        public bool? VatRem { get; set; }
    }
}
