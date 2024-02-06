namespace LotteryGameWebAPI
{
    using Microsoft.AspNetCore.SignalR;
    using System;
    using System.Threading;
    using System.Threading.Tasks;

    public class LotteryHub : Hub
    {
        private readonly IHubContext<LotteryHub> _hubContext;

        public LotteryHub(IHubContext<LotteryHub> hubContext)
        {
            _hubContext = hubContext;
        }

        public async Task DrawLotteryNumbers()
        {
            // Simulate lottery number generation
            var lotteryResult = LotteryGameWebAPI.Controllers.LotteryController.Draw(); //new Random().Next(1000, 9999);

            // Broadcast the lottery result to all connected clients
            await _hubContext.Clients.All.SendAsync("ReceiveLotteryNumbers", lotteryResult);
        }
    }

}
