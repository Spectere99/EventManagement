using System;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace HttpClientSample
{
   class Program
    {
        static HttpClient client = new HttpClient();

        
        static async Task<Uri> ExpireRegistrationCodes()
        {
            HttpResponseMessage response = await client.PostAsync("api/maintenance/ExpireWaitingListCodes", null);
            response.EnsureSuccessStatusCode();

            // return URI of the created resource.
            return response.Headers.Location;
        }

        

        static void Main()
        {
            RunAsync().Wait();
        }

        static async Task RunAsync()
        {
            client.BaseAddress = new Uri("http://localhost:50337/");
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            try
            {
               var url = await ExpireRegistrationCodes();
               

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            
        }

    }
}

