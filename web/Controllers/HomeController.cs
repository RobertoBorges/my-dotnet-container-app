using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MyApp.Data;
using MyApp.Models;

namespace MyApp.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly UserRepository _userRepository;

    public HomeController(ILogger<HomeController> logger, IConfiguration configuration)
    {
        _logger = logger;
        _userRepository = new UserRepository(configuration.GetConnectionString("DefaultConnection"));
    }

    public async Task<IActionResult> Index()
    {
        try
        {
            var users = await _userRepository.GetAllUsersAsync();
            return View(users);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error fetching users from database");
            ViewBag.ErrorMessage = "Could not connect to the database. " + ex.Message;
            return View(new List<User>());
        }
    }

    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
