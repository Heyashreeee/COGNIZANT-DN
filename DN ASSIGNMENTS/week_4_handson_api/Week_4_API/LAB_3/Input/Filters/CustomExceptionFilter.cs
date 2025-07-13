using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace WebApiDemo.Filters
{
    public class CustomExceptionFilter : IExceptionFilter
    {
        public void OnException(ExceptionContext context)
        {
            // Log error to a file
            var logPath = Path.Combine(Directory.GetCurrentDirectory(), "errors.txt");
            File.AppendAllText(logPath, $"[{DateTime.Now}] {context.Exception.Message}{Environment.NewLine}");

            // Return generic error response to user
            context.Result = new ObjectResult("Internal Server Error occurred.")
            {
                StatusCode = 500
            };
        }
    }
}
