namespace WebApi_Handson.Models
{
    public class Employee
    {
        public int Id { get; set; }               // Unique employee ID
        public string Name { get; set; }          // Employee's name
        public string Department { get; set; }    // Department they work in
        public double Salary { get; set; }        // Salary amount
    }
}
