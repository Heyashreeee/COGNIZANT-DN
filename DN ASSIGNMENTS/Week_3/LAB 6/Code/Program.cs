using Microsoft.EntityFrameworkCore;
using RetailInventory;
using System;
using System.Linq;

class Program
{
    static async Task Main(string[] args)
    {
        using var context = new AppDbContext();

        // UPDATE: Change the price of "Laptop"
        var laptop = context.Products.FirstOrDefault(p => p.Name == "Laptop");
        if (laptop != null)
        {
            laptop.Price = 70000;
            await context.SaveChangesAsync();
            Console.WriteLine("Laptop price updated.");
        }

        // DELETE: Remove "Rice Bag"
        var riceBag = context.Products.FirstOrDefault(p => p.Name == "Rice Bag");
        if (riceBag != null)
        {
            context.Products.Remove(riceBag);
            await context.SaveChangesAsync();
            Console.WriteLine("Rice Bag deleted.");
        }

        // DISPLAY updated products
        var products = context.Products.Include(p => p.Category).ToList();
        Console.WriteLine("Products after update/delete:");
        foreach (var product in products)
        {
            Console.WriteLine($"Name: {product.Name}, Price: {product.Price}, Category: {product.Category?.Name}");
        }
    }
}
