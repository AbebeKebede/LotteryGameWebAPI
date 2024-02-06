using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace LotteryGameWebAPI
{
    public class LotteryDrawService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;

        public LotteryDrawService(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                // Draw lottery numbers every hour
                await DrawLotteryNumbersAsync();

                // Wait for one hour before the next draw
                await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
            }
        }

        private async Task DrawLotteryNumbersAsync()
        {
            using (var scope = _serviceProvider.CreateScope())
            {
                var lotteryResult = LotteryGameWebAPI.Controllers.LotteryController.Draw();
                var lotteryHub = scope.ServiceProvider.GetRequiredService<IHubContext<LotteryHub>>();
                await lotteryHub.Clients.All.SendAsync("DrawLotteryNumbers", "Solomon Etafa");
            }
        }
    }
}
