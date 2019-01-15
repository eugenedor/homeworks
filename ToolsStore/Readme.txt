МАГАЗИН ИНСТРУМЕНТОВ "ToolsStore"

ToolsStore.WebUI     - ASP.NET MVC
ToolsStore.Domain    - DLL-библиотека, ADO.NET Entity Framework
ToolsStore.UnitTests - Unit-тесты
ToolsStoreService    - Windows-служба по загрузке XML в БД


Описание сущностей в БД
Префиксы:
CT - каталог
SK - справочник
RS - реестр
MT - метаданные

Сущности:
CT_BRAND     - бренд
CT_CATEGORY  - категории
CT_IMAGE     - образы изображений товаров
CT_VAT       - ндс
MT_LOAD_RULE - правило загрузки xml-файла по xsd
MT_SETTING   - настройки
RS_CART      - содержание заказа
RS_ORDER     - заказ товара
RS_PRICE     - цены товара
RS_PRODUCT   - товар
SK_EQUIPMENT - оборудование
SK_MODEL     - модель товара