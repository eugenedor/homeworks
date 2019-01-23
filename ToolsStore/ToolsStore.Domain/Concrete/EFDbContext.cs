using System;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Entities
{

    public partial class EFDbContext : DbContext
    {
        public EFDbContext()
            : base("name=EFDbContext")
        {
        }

        public virtual DbSet<CT_BRAND> CT_BRAND { get; set; }
        public virtual DbSet<CT_CATEGORY> CT_CATEGORY { get; set; }
        public virtual DbSet<CT_IMAGE> CT_IMAGE { get; set; }
        public virtual DbSet<CT_VAT> CT_VAT { get; set; }
        public virtual DbSet<MT_LOAD_RULE> MT_LOAD_RULE { get; set; }
        public virtual DbSet<MT_LOAD_RULE_SPEC> MT_LOAD_RULE_SPEC { get; set; }
        public virtual DbSet<MT_SETTING> MT_SETTING { get; set; }
        public virtual DbSet<RS_CART> RS_CART { get; set; }
        public virtual DbSet<RS_ORDER> RS_ORDER { get; set; }
        public virtual DbSet<RS_PRICE> RS_PRICE { get; set; }
        public virtual DbSet<RS_PRODUCT> RS_PRODUCT { get; set; }
        public virtual DbSet<SK_EQUIPMENT> SK_EQUIPMENT { get; set; }
        public virtual DbSet<SK_MODEL> SK_MODEL { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CT_BRAND>()
                .HasMany(e => e.SK_MODEL)
                .WithRequired(e => e.CT_BRAND)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CT_CATEGORY>()
                .HasMany(e => e.SK_EQUIPMENT)
                .WithRequired(e => e.CT_CATEGORY)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CT_IMAGE>()
                .Property(e => e.MimeType)
                .IsUnicode(false);

            modelBuilder.Entity<CT_IMAGE>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<CT_VAT>()
                .HasMany(e => e.RS_PRICE)
                .WithRequired(e => e.CT_VAT)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<MT_LOAD_RULE>()
                            .HasMany(e => e.MT_LOAD_RULE_SPEC)
                            .WithRequired(e => e.MT_LOAD_RULE)
                            .WillCascadeOnDelete(false);

            modelBuilder.Entity<MT_LOAD_RULE_SPEC>()
                .Property(e => e.MimeType)
                .IsUnicode(false);

            modelBuilder.Entity<MT_LOAD_RULE_SPEC>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<RS_ORDER>()
                .HasMany(e => e.RS_CART)
                .WithRequired(e => e.RS_ORDER)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<RS_PRICE>()
                .Property(e => e.PriceWithVat)
                .HasPrecision(17, 2);

            modelBuilder.Entity<RS_PRICE>()
                .Property(e => e.PriceWithoutVat)
                .HasPrecision(17, 2);

            modelBuilder.Entity<RS_PRODUCT>()
                .Property(e => e.Mass)
                .HasPrecision(10, 3);

            modelBuilder.Entity<RS_PRODUCT>()
                .Property(e => e.Length)
                .HasPrecision(10, 2);

            modelBuilder.Entity<RS_PRODUCT>()
                .Property(e => e.Width)
                .HasPrecision(10, 2);

            modelBuilder.Entity<RS_PRODUCT>()
                .Property(e => e.Height)
                .HasPrecision(10, 2);

            modelBuilder.Entity<RS_PRODUCT>()
                .HasMany(e => e.RS_CART)
                .WithRequired(e => e.RS_PRODUCT)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<RS_PRODUCT>()
                .HasMany(e => e.RS_PRICE)
                .WithRequired(e => e.RS_PRODUCT)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SK_EQUIPMENT>()
                .HasMany(e => e.RS_PRODUCT)
                .WithRequired(e => e.SK_EQUIPMENT)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SK_MODEL>()
                .HasMany(e => e.RS_PRODUCT)
                .WithRequired(e => e.SK_MODEL)
                .WillCascadeOnDelete(false);
        }
    }
}
