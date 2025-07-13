using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using WebApi_Handson.Models;

namespace WebApi_Handson.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeeController : ControllerBase
    {
        private static List<Employee> employees = new List<Employee>
        {
            new Employee { Id = 1, Name = "Alice", Department = "HR", Salary = 45000 },
            new Employee { Id = 2, Name = "Bob", Department = "IT", Salary = 55000 },
            new Employee { Id = 3, Name = "Charlie", Department = "Sales", Salary = 50000 }
        };

        [HttpPut("{id}")]
        public ActionResult<Employee> UpdateEmployee(int id, [FromBody] Employee input)
        {
            if (id <= 0)
                return BadRequest("Invalid employee id");

            var emp = employees.FirstOrDefault(e => e.Id == id);
            if (emp == null)
                return BadRequest("Invalid employee id");

            emp.Name = input.Name;
            emp.Department = input.Department;
            emp.Salary = input.Salary;

            return Ok(emp);
        }

        [HttpGet]
        public ActionResult<IEnumerable<Employee>> GetEmployees()
        {
            return Ok(employees);
        }

        [HttpPost]
        public ActionResult<Employee> AddEmployee([FromBody] Employee newEmployee)
        {
            if (newEmployee == null || string.IsNullOrWhiteSpace(newEmployee.Name))
                return BadRequest("Invalid employee data");

            newEmployee.Id = employees.Max(e => e.Id) + 1;
            employees.Add(newEmployee);

            return CreatedAtAction(nameof(UpdateEmployee), new { id = newEmployee.Id }, newEmployee);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteEmployee(int id)
        {
            var emp = employees.FirstOrDefault(e => e.Id == id);
            if (emp == null)
                return NotFound("Employee not found");

            employees.Remove(emp);
            return NoContent();
        }
    }
}
