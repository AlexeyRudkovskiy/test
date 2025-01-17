# Use the .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project files to the container
COPY . ./
RUN dotnet restore

# Build the application
RUN dotnet publish -c Release -o out

# Create the final image using the .NET Core runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .


# Run the application
#ENTRYPOINT ["dotnet", "TestNet.dll"]
ENTRYPOINT ["dotnet", "TestNet.dll", "--urls", "http://*:5000"]
