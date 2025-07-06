using Microsoft.EntityFrameworkCore;
using RetailInventory;
using System;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        using var context = new AppDbContext();

        var productsWithCategory = context.Products
            .Include(p => p.Category)
            .ToList();

        Console.WriteLine("Product List:");
        foreach (var product in productsWithCategory)
        {
            Console.WriteLine($"Name: {product.Name}, Price: {product.Price}, Category: {product.Category.Name}");
        }
    }
}
