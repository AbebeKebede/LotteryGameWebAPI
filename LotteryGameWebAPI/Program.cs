using LotteryGameWebAPI;

var builder = WebApplication.CreateBuilder(args);
var MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddSignalR();

builder.Services.AddCors(options =>
{
    options.AddPolicy(name: MyAllowSpecificOrigins,
                      policy =>
                      {
                          policy.WithOrigins("http://localhost:25985", "http://localhost:83", "https://localhost:7011").AllowAnyHeader().AllowAnyMethod().AllowCredentials();
                      });
});

builder.Services.AddHostedService<LotteryDrawService>();


var app = builder.Build();
app.UseCors(MyAllowSpecificOrigins);
app.UseRouting();
app.UseAuthorization();
app.UseEndpoints(endpoints =>
{
        endpoints.MapHub<LotteryHub>("/lotteryHub");
        endpoints.MapControllers();
        // Other Configure logic...
});


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}



app.UseHttpsRedirection();



app.MapControllers();

app.Run();


