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
            Console.WriteLine(Method1Async(cl).Result);

            //ThirdAsync
            Console.WriteLine(Method2Async(cl, str).Result);

            Console.ReadKey();
        }

        static async Task<string> Method1Async(FirstWCFServiceClient c)
        {
            return await c.SecondAsync();
        }

        static async Task<string> Method2Async(FirstWCFServiceClient c, string txt)
        {
            return await c.ThirdAsync(txt);
        }
    }
}
