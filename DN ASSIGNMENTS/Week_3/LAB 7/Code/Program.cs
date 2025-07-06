using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace RetailInventory
{
    class Program
    {
        static async Task Main(string[] args)
        {
            using var context = new AppDbContext();

            Console.WriteLine("📦 All Categories:");
            var categories = await context.Categories.ToListAsync();
            foreach (var category in categories)
            {
                Console.WriteLine($"- {category.Name}");
            }

            Console.WriteLine("\n🛒 All Products with Categories:");
            var products = await context.Products.Include(p => p.Category).ToListAsync();
            foreach (var product in products)
            {
                Console.WriteLine($"- {product.Name} | ₹{product.Price} | Category: {product.Category.Name}");
            }

            Console.WriteLine("\n💰 Products with Price > ₹1000:");
            var expensiveProducts = await context.Products
                .Where(p => p.Price > 1000)
                .Include(p => p.Category)
                .ToListAsync();

            foreach (var product in expensiveProducts)
            {
                Console.WriteLine($"- {product.Name} | ₹{product.Price} | Category: {product.Category.Name}");
            }
        }
    }
}
