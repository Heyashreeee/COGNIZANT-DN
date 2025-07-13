using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace MyFirstApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    // <-- Custom route
    public class EmployeeController : ControllerBase
    {
        // GET: api/emp
        [HttpGet]
        public IActionResult Get()
        {
            var employees = new List<string> { "SUbham", "Sristi", "Suman" };
            return Ok(employees);
        }
    }
}
