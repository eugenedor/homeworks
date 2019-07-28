using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ConsApp.ServiceReference1;

namespace ConsApp
{
    class Program
    {
        static void Main(string[] args)
        {
            var cl = new FirstWCFServiceClient();

            //First
            string str = Console.ReadLine();
            Console.WriteLine(cl.First(str));

            //SecondAsync
            Console.WriteLine(MethodAsync(cl).Result);

            Console.ReadKey();
        }

        static async Task<string> MethodAsync(FirstWCFServiceClient c)
        {
            return await c.SecondAsync();
        }
    }
}
