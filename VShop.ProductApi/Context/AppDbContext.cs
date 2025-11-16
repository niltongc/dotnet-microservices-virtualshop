using Microsoft.EntityFrameworkCore;
using VShop.ProductApi.Models;

namespace VShop.ProductApi.Context;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
        
    }
    
    public DbSet<Category> Categories { get; set; }
    public DbSet<Product>  Products { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // category
        modelBuilder.Entity<Category>().HasKey(c => c.CategoryId);
        
        modelBuilder.Entity<Category>()
            .Property(c => c.Name)
            .HasMaxLength(100)
            .IsRequired();
        
        // product
        modelBuilder.Entity<Product>()
            .Property(p => p.Name)
            .HasMaxLength(100)
            .IsRequired();
        
        modelBuilder.Entity<Product>()
            .Property(p => p.Description)
            .HasMaxLength(255)
            .IsRequired();
        
        modelBuilder.Entity<Product>()
            .Property(p => p.ImageURL)
            .HasMaxLength(255)
            .IsRequired();
        
        modelBuilder.Entity<Product>()
            .Property(p => p.Price)
            .HasPrecision(12,2)
            .IsRequired();
        
        modelBuilder.Entity<Category>()
            .HasMany(g => g.Products)
            .WithOne(c => c.Category)
            .IsRequired()
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<Category>().HasData(
            new Category
            {
                CategoryId = 1,
                Name = "Scholar objects"
            },
            new Category
            {
                CategoryId = 2,
                Name = "accessories"
            }
        );
    }
}