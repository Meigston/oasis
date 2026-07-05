var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

// Health check exigido pela PoC
app.MapGet("/health", () => Results.Ok(new { status = "healthy" }));

app.MapGet("/", () => Results.Ok(new { service = "${{ values.appName }}", status = "running" }));

app.Run();
