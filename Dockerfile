#
#1. Intermediate layer
#
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS lbuild

#1.1. Copy all csproj files and restore dependencies
WORKDIR /src
COPY ["webservices/webservices.csproj", "webservices/"]
RUN dotnet restore "webservices/webservices.csproj"

#1.2. Copy the rest of the code (use un ".dockerignore")
COPY . .

#1.3. Build the application
RUN dotnet build "webservices/webservices.csproj" -c Release -o /app/build

#1.4. Publish the application
RUN dotnet publish "webservices/webservices.csproj" -c Release -o /app/publish /p:UseAppHost=false



#
#2. Final layer
#
FROM mcr.microsoft.com/dotnet/aspnet:8.0

#2.1. Set container port
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

#2.2. Create non-root user and set working directory
WORKDIR /app
#RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
#USER appuser

#2.2. Copy pubish files
COPY --from=lbuild /app/publish .

#2.3. Add others files and folders
RUN mkdir -p /app/log

#2.4. Only for testing
#RUN apt-get update && apt-get install sudo 
#RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 

#2.5. Set the entrypoint
ENTRYPOINT ["dotnet", "PoC.TestWSrv1.WebServices.dll"]
