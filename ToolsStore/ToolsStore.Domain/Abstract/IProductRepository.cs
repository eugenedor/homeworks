using System.Linq;
using ToolsStore.Domain.Entities;
using System.Collections.Generic;

namespace ToolsStore.Domain.Abstract
{
    public interface IProductRepository
    {
        IQueryable<RS_PRODUCT> Productts { get; }

        IQueryable<SK_EQUIPMENT> Equipments { get; }

        IQueryable<CT_CATEGORY> Categories { get; }

        IQueryable<CT_BRAND> Brands { get; }

        IQueryable<SK_MODEL> Models { get; }

        IQueryable<CT_IMAGE> Images { get; }

        IQueryable<RS_PRICE> Prices { get; }

        IQueryable<CT_VAT> Vats { get; }

        IQueryable<CT_CATEGORY> NavCategories { get; }

        IQueryable<SK_EQUIPMENT> NavEquipments { get; }

        IEnumerable<PRODUCT> Products { get; }

        void SaveCategory(CT_CATEGORY category);

        CT_CATEGORY DeleteCategory(long categoryId);

        void SaveVat(CT_VAT vat);

        CT_VAT DeleteVat(long vatId);

        void SaveEquipment(SK_EQUIPMENT equipment);

        SK_EQUIPMENT DeleteEquipment(long equipmentId);

        void SaveProduct(RS_PRODUCT product);

        RS_PRODUCT DeleteProduct(long productId);

        void SaveBrand(CT_BRAND brand);

        CT_BRAND DeleteBrand(long brandId);

        void SaveModel(SK_MODEL mdl);

        SK_MODEL DeleteModel(long modelId);

        void RefreshEquipmentIsActive();

        void SetEquipmentIsActive(bool isActive);

        void SavePrice(RS_PRICE price);

        RS_PRICE DeletePrice(long priceId);

        void ClearImage(long productId);

        string NameApp();
    }
}
