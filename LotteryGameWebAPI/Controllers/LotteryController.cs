//using LotteryGameWebAPI.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading;
using Module;
using Microsoft.EntityFrameworkCore;
namespace LotteryGameWebAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LotteryController : ControllerBase
    {
        private static List<int> lotteryTickets = new List<int>();
        private static int lotteryResult;
        private static DateTime nextLotteryDraw = DateTime.UtcNow.AddHours(1);

        /*[HttpPost("buyTicket")]
        public IActionResult BuyTicket()
        {
            using(var db = new LotteryGameModelContainer())
            {
                var user = new Users{ balance = 0, email = "email", username= "username", password_hash="oiwerfoawf" };
                db.Users.Add(user);
                db.SaveChanges();
            }

            // Logic for handling payment and updating the database with purchased ticket
            // For simplicity, store ticket in-memory
            var randomTicket = new Random().Next(100000, 999999);
            lotteryTickets.Add(randomTicket);

            // For simplicity, return a success status
            return Ok(new { success = true , ticketNumber = randomTicket });
        }*/
        [HttpPost("buyTicket")]
        public IActionResult BuyTicket([FromBody] TicketRequest request)
        {
            int randomTicket;
            if (request == null || string.IsNullOrWhiteSpace(request.Email) || string.IsNullOrWhiteSpace(request.Username))
            {
                return BadRequest("Invalid request. Email and username are required.");
            }

            using (var db = new LotteryGameModelContainer())
            {
                var user = new Users { balance = 0, email = request.Email, username = request.Username, password_hash = "oiwerfoawf" };
                db.Users.Add(user);
                db.SaveChanges();

                // Logic for handling payment and updating the database with purchased ticket
                // For simplicity, store ticket in-memory
                randomTicket = new Random().Next(100000, 999999);
                lotteryTickets.Add(randomTicket);

                using (var dbTickets = new LotteryGameModelContainer())
                {
                    var tickets = new Tickets { user_id_fk = user.Id,lottery_id_fk=6,is_winner=false,numbers = randomTicket,purchase_time=DateTime.Today,Lottery = new Lotteries { },User = user };
                    dbTickets.Tickets.Add(tickets);
                    dbTickets.SaveChanges();
                }
            }

            // For simplicity, return a success status
            return Ok(new { success = true, ticketNumber = randomTicket });
        }
        [HttpGet("generateLotteryNumbers")]
        public IActionResult GenerateLotteryNumbers()
        {
            // Simulate lottery number generation
            lotteryResult = new Random().Next(0, lotteryTickets.Count);

            // Reset the next lottery draw time
            nextLotteryDraw = DateTime.UtcNow.AddHours(1);

            // Broadcast lottery result to clients (for a real-world scenario, use SignalR)
            // For simplicity, return the result in the response
            return Ok(new { success = true, lotteryNumbers = lotteryTickets[lotteryResult] });
        }

        public static int Draw()
        {
            lotteryResult = new Random().Next(0, lotteryTickets.Count);
            if(lotteryTickets.Count>0)
                return lotteryTickets[lotteryResult];

            return -1;

    }

        [HttpGet("getNextLotteryDraw")]
        public IActionResult GetNextLotteryDraw()
        {
            // Return the next lottery draw time
            return Ok(new { nextLotteryDraw });
        }
    }

    public class TicketRequest
    {
        public string Email { get; set; }
        public string Username { get; set; }
    }
}
